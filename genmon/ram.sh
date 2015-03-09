#!/bin/bash

echo "<txt>M: "$(free -h | grep "Mem:" | awk '{ print $3 }')"</txt>"
