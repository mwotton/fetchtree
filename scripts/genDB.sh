#!/bin/env bash

set -eou pipefail;

depth=$1;
branch=$2;


echo "create table T0 (id serial primary key);"
echo "insert into T0 values(default);"
for i in `seq 1 $depth`; do
    parent=$((i - 1));
    
    echo "create table T$i(id serial primary key, parent int references T$parent(id));";
    echo "create index on T$i(parent);";
    echo "with dupes as (select generate_series(1,$branch)) insert into T$i (parent) (select id from T$parent,dupes);"
done;

