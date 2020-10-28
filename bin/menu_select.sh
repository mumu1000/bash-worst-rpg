#!/bin/bash

#Menu from elements in an array, echoes choice index
#Usage choixtableau choices[]

menu_select() {
    local banner="$1"
    shift
    local menu=("${@}")
    local getout=0
    local menuResult=0
    while ((getout!=1))
        do
        clear
        echo "$banner"
            for item in ${!menu[*]}
            do
                if [[ $item == $menuResult ]]; then
                    echo -e "\033[7m""${menu[$item]}""\033[0m" >&2
                else
                    echo "${menu[$item]}" >&2
                fi
            done

        local good=0
        while ((good!=1))
        do
            read -sn 1 aze
            case "$aze" in
                a|z|e)
                    good=1
                    if [[ 0 == $menuResult ]]; then
                        menuResult=${#menu[*]}
                    fi
                    menuResult=$((menuResult-1))
                    ;;
                q|s|d)
                    good=1
                    menuResult=$((menuResult+1))
                    if [[ ${#menu[*]} == $menuResult ]]; then
                        menuResult=0
                    fi
                    ;;
                "")
                    good=1
                    getout=1
                    ;;
                *)
                    good=0
                    ;;
            esac
        done
    done
    echo $menuResult
}
