#!/usr/bin/bash

if [[ "$(ls)" == *orig* ]]
then
	rm -f *.orig
	rm -f *.rej
fi

if [ ! -f "dwm.c" ]
then
	exit 1
fi

rm -f config.h
make
sudo make install
make clean
rm -f config.h
