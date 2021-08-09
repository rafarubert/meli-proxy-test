#!/bin/bash

bundle check || bundle install
exec "$@"
