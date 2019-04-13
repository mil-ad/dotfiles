# !/usr/bin/env bash

while read p; do
  code --install-extension $p
done < $PWD/extensions-list.txt

echo 
echo ===============================
echo Importing Completed.
echo ===============================
