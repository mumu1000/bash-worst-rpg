#!/bin/bash

#Generates a map using properties defined in config.cfg
#Usage generate_map path mapfolder

generate_locality_in() {
    local templates=( $(find "../data/locality_templates/" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;) )
    for a in "${templates[@]}"
        do if [[ "$2" =~ ^${a}$ ]] ; then
        local location_path="${1}/$(uuid)"
        mkdir -p "${location_path}"
        . ../data/locality_templates/${a}/render.sh 
        render_template "${location_path}"
        echo "${location_path}"
        fi
    done
}

generate_region() {
    generate_locality_in "${1}" "region_capital" 1>/dev/null
}

generate_country() {
    for i in $(seq 1 $(random_int 1 7))
        do local region_name="$(uuid)"
        mkdir -p "${1}/${region_name}"
        set_property "region_name" "${region_name}" "${1}/${region_name}/region_properties"
        set_property "discovered" "false" "${1}/${region_name}/region_properties"
    done
    local capital_region="${1}/$(take_location_random ${1})"
    generate_if_needed "${capital_region}" "region"
    generate_locality_in "${capital_region}" "country_capital" 1>/dev/null
}

generate_continent() {
    for i in $(seq 1 $(random_int 1 7))
        do local country_name="$(uuid)"
        mkdir -p "${1}/${country_name}"
        set_property "country_name" "${country_name}" "${1}/${country_name}/country_properties"
        set_property "discovered" "false" "${1}/${country_name}/country_properties"
    done
}

generate_map() {
    set_property "world_name" "$(uuid)" "${1}/world_properties"
    for i in $(seq 1 $(random_int 1 7))
        do local cont_name="$(uuid)"
        mkdir -p "${1}/${cont_name}"
        set_property "continent_name" "${cont_name}" "${1}/${cont_name}/continent_properties"
        set_property "discovered" "false" "${1}/${cont_name}/continent_properties"
    done
}

generate_if_needed() {
    if (( "$(find "${1}" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | wc -l)" == "0" )) ;then
        case "$2" in
            "continent")
                generate_continent "${1}"
                ;;
            "country")
                generate_country "${1}"
                ;;
            "region")
                generate_region "${1}"
                ;;
            *)
                echo "WRONG NODE MAP TYPE !" >&2
                ;;
        esac
    fi
}