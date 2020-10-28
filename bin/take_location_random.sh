#!/bin/bash

#Chooses a location at random from a node in the map tree
#Usage take_location_random str node_path

take_location_random() {
    local loc_list=$(find "$1" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
    local chosen=$(random_int 0 $(( $(echo "$loc_list" | wc -l) - 1 )) )
    local arr=($(echo "$loc_list"))
    echo ${arr[${chosen}]}
}