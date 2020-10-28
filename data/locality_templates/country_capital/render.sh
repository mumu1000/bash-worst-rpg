#!/bin/bash

#Generates a locality by implementing a country_capital template
#Usage render_template path locality

render_template() {
    local country_name=$(get_property "country_name" "${1}/../../country_properties")
    set_property "locality_name" "Capital of ${country_name}" "${1}/locality_properties"
    set_property "discovered" "false" "${1}/locality_properties"
}