#!/bin/bash

# Mount primary remote driver from server-mystic
# Example: ./mount-server.sh on | ./mount-server.sh off

if [[ $1 == "off" ]]; then
  fusermount -u /home/marko/Music/
  fusermount -u /home/marko/Videos/
  fusermount -u /home/marko/Pictures/
  fusermount -u /home/marko/Documents/
elif [[ $1 == "on" ]]; then
  sshfs marko@192.168.1.188:/home/Primary/Audio/Music/ /home/marko/Music/ -o idmap=user -o umask=0 -o gid=1000 -o uid=1000
  sshfs marko@192.168.1.188:/home/Primary/Videos/ /home/marko/Videos/ -o idmap=user -o umask=0 -o gid=1000 -o uid=1000
  sshfs marko@192.168.1.188:/home/Primary/Pictures/ /home/marko/Pictures/ -o idmap=user -o umask=0 -o gid=1000 -o uid=1000
  sshfs marko@192.168.1.188:/home/Primary/Documents/ /home/marko/Documents/ -o idmap=user -o umask=0 -o gid=1000 -o uid=1000
else
  echo "Please use 'add' or 'remove' parameter.";
  exit 1
fi

exit 0;

