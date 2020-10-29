#!/bin/bash

#Used to apply a template to an existing item
#Usage void render_item_attr path item_path str attr_name str attr_trigger int attr_level int item_quality int item_level

# 1 item_path
# 2 attr_name
# 3 attr_trigger
# 4 attr_level
# 5 item_quality
# 6 item_level

render_item_attr() {
    local entered_section=0
    local cond_depth=0
    local cond_inval=0
    local curr_trigg_name="${3}"
    local ITEM_PATH="${1}"
    local ATTR_LEVEL="${4}"
    local ITEM_QUALITY="${5}"
    local ITEM_LEVEL="${6}"
    local ITEM_NAME="$( basename ${1} )"
    local ATTR_ID="$( uuid )"
    declare -a sedargs
    while read -r i <&4
        do sedargs+=("-e" "s/###${i}###/${!i}/g")
    done 4<<<"$(echo -e ATTR_LEVEL\\nITEM_QUALITY\\nITEM_LEVEL\\nITEM_NAME\\nITEM_PATH\\nATTR_ID)"
    while IFS= read -r line <&3
        do if [ -z "$line" ] ; then continue ; fi
        grep "^###BEGIN__${3}__" <<< "$line" >/dev/null && entered_section=1 && continue
        grep "^###END__${3}__" <<< "$line" >/dev/null && entered_section=0 && continue
        if [ ! $entered_section -eq 1 ] ; then
            continue
        fi

        if grep "^###IF " <<< "$line" >/dev/null ; then 
            (( cond_depth++ ))
            (( cond_inval )) && (( cond_inval++ )) && continue
            line=$(grep -oP "(?<=^###IF ).*$" <<< "$line")
            (( ! (line) )) && (( cond_inval++ ))
            continue
        fi

        if grep "^###ENDIF" <<< "$line" >/dev/null ; then 
            (( cond_depth-- ))
            (( cond_inval )) && (( cond_inval-- ))
            continue
        fi

        if grep "^###ELSE" <<< "$line" >/dev/null ; then 
            (( cond_inval == 1 )) && (( cond_inval-- ))
            (( ! cond_inval )) && (( cond_inval++ ))
            continue
        fi

        if grep "^###DELEGATE " <<< "$line" >/dev/null ; then 
            curr_trigg_name=$(grep -oP "(?<=^###DELEGATE ).*$" <<< "$line")
            continue
        fi

        if grep "^###ENDDELEGATE" <<< "$line" >/dev/null ; then 
            curr_trigg_name="${3}"
            continue
        fi

        if [ $cond_inval -ge 1 ] ; then
            continue
        fi

        line=$( sed "${sedargs[@]}" <<<"${line}")
        echo "$line" >> "${1}/${curr_trigg_name}"
    done 3<"../data/item_properties_templates/${2}"
}