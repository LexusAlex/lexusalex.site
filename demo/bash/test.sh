#!/bin/bash
x=12
echo $x
echo "$x"
echo 'i don'\''t d'
echo "Текущее время: `date +%T`"
let test=1+2
echo $test
echo $((3+3+3))

if test -f /etc/foo; then
  echo "Есть файл"
fi
  echo "Файла нет"

if test -f /etc/foo; then echo "Есть файл"; echo "Файла нет";fi
