#!/bin/bash

/etc/init.d/postgresql start
cd repo
bundle exec rails server -b 0.0.0.0
