#!/bin/bash

function help(){
    echo 'Syntax: mysqlTableToCSV.sh <database name> <table name>'
    echo '    <database name>: database name'
    echo '    <table name>: mysql table'
}

function exportTableToCSV(){
    $dbName = $1
    $tableName = $2
    mysql -u root -p ${dbName} -B -e "select * from ${tableName};" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' > ${tableName}.csv
}

$dbName = $1
$tableName = $2

if [ -z "${dbName}" ]; then
    help
    exit
fi
if [ -z "${tableName}" ]; then
    help
    exit
fi

exportTableToCSV $dbName $tableName
