#!/bin/sh

bundle check || bundle install
exec "$@"
