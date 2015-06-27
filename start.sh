#!/bin/bash

/etc/init.d/postgresql start
cd repo
./bin/rails server -b 0.0.0.0
