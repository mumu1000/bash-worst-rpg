#!/bin/bash

#Set property propname in file pathpropfile
#Usage void setproperty str propname str value str pathpropfile

set_property() {
    sed -si "/^#${1} /d" "${3}" 2>/dev/null
    echo "#${1} ${2}" >> "${3}"
}
