#!/bin/bash

DATABASE='sales'

folder=/home/project

sqlfile=$folder/sales-$(date +%d-%m-%Y_%H-%M-%S).sql

if mysqldump $DATABASE > $sqlfile; then
    echo 'The dump was successfully created'
else
    echo 'Error creating dump'
    exit
fi