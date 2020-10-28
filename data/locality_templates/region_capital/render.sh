#!/bin/bash

#Generates a locality by implementing a region_capital template
#Usage render_template path locality

render_template() {
    local region_name=$(get_property "region_name" "${1}/../region_properties")
    set_property "locality_name" "Regional-Capital of ${region_name}" "${1}/locality_properties"
    set_property "discovered" "false" "${1}/locality_properties"
}