# !/usr/bin/env bash

code --list-extensions | tee extensions-list.txt


while read p; do
  #code --install-extension $p
  echo Importing $p
done < $PWD/extensions-list.txt

echo 
echo ===============================
echo Importing Completed.
echo ===============================
