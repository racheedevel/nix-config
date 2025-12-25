#!/bin/bash

specname=$1

location=$(pwd)/lua/plugins

echo "Creating $specname... at $location"

echo "
return {}
" >> $location/$specname.lua
