#!/bin/bash

subl3 ~/.config/polybar/config
killall -9 polybar
polybar -r default
