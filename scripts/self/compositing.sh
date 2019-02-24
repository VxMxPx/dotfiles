#!/bin/bash

# Turn xfce4 compositing on/off

xfconf-query -c xfwm4 -p /general/use_compositing -T
