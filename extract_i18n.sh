#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsureport/locale

pot-create -o unicorecmsureport/locale/unicorecmsureport.pot unicorecmsureport/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsureport/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsureport/locale/""$lang""/LC_MESSAGES/unicorecmsureport.po" ]; then
        msginit -l $lang -i unicorecmsureport/locale/unicorecmsureport.pot -o unicorecmsureport/locale/$lang/LC_MESSAGES/unicorecmsureport.po
    fi

    msgmerge --update unicorecmsureport/locale/$lang/LC_MESSAGES/unicorecmsureport.po unicorecmsureport/locale/unicorecmsureport.pot
    msgfmt unicorecmsureport/locale/$lang/LC_MESSAGES/*.po -o unicorecmsureport/locale/$lang/LC_MESSAGES/unicorecmsureport.mo
done
