#!/bin/bash
set -e
if ! psql -U "$POSTGRES_USER" -lqt | cut -d \| -f 1 | grep -qw ragdb; then
  psql -U "$POSTGRES_USER" -c "CREATE DATABASE ragdb;"
fi
