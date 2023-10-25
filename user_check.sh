#!/bin/bash

echo "Enter a username to check: "
read name

if grep $name /etc/passwd > /dev/null; then
  echo "$name is on this system"
else
  echo "$name does not exist"
fi
