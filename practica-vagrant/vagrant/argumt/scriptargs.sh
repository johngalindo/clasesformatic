#!/usr/bin/env bash
#
# Este script en bash recibe como argumentos una serie de cadenas y usará cada
# una de estas cadenas como el nombre de un archivo
#
for i in "$@"; do
  touch /tmp/"${i}"
done
