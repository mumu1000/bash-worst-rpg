#!/bin/bash

#Usage void int quality int level int creation_points path item_path

generate_item() {
    mkdir -p "${4}"
    item_type=$( find ../data/item_types/ -type f -exec basename {} \; | shuf -n 1 )
}