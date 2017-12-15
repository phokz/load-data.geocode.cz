# load-data.geocode.cz

ruby and bash scripts to load data from
http://nahlizenidokn.cuzk.cz/stahniadresnimistaruian.aspx

to the database.

1. create database
2. cp mysql.cnf.sample mysql.cnf && editor mysql.cnf
3. ./download.rb && ./preprocess.sh && ./import.rb && ./import.sh


UPDATE: they changed the data format recently, so that
streets have their ID and so. This needs to be updated
to use provided ids instead of inventing own ids.

