#!/bin/sh 

killall redshift
killall redshift
killall redshift

#escribir latitud y longitud con dos decimales
#lat=0.00
#long=0.00

redshift -x
redshift -l $lat:$long -t 4800K:2500K
