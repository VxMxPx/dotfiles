#!/bin/bash

polybar-msg hook updates-arch 3 >/dev/null 2>&1

yaourt -Syua
sudo paccache -r
sudo paccache -ruk0

polybar-msg hook updates-arch 1 >/dev/null 2>&1

echo "All done!"
read line