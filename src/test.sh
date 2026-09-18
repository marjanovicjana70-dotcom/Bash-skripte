#!/bin/bash

function testiranje(){

read -r -p "$1 [$2]: " input

echo "${input:-$2}"

}



testiranje "Unesi neki broj" 10