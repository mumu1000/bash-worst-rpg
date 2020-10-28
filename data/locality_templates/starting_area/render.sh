#!/bin/bash

#Generates a locality by implementing a starting_area template
#Usage render_template path locality

render_template() {
    set_property "locality_name" "Player_starting_point" "${1}/locality_properties"
    set_property "discovered" "true" "${1}/locality_properties"
}