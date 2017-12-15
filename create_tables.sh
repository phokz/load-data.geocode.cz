#!/bin/bash

mysql='mysql --defaults-file=mysql.cnf'

$mysql < schema.sql
