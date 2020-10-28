#!/bin/bash

#Get property propname from file pathpropfile
#Usage str getproperty str propname str pathpropfile

get_property() {
    grep -oP "(?<=^${1} ).*$" "${2}" 2>/dev/null | head -n 1
}
