#!/bin/bash

# From https://stackoverflow.com/a/29254487/1657936
hexdump -v -e '5/1 "%02x""\n"' /dev/urandom | awk -v OFS=',' '
    NR == 1 { print "foo", "bar", "baz" }
    { print substr($0, 1, 8), substr($0, 9, 2), int(NR * 32768 * rand()) }' |
    head -n 3000000 > big_csv.csv
