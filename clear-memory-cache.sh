#!/usr/bin/env bash
# Note, we are using "echo 3", but it is not recommended in production instead use "echo 1"
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches