#!/bin/bash

# Mount primary remote driver from server-mystic
# Example: ./mount-server.sh on | ./mount-server.sh off

if [[ $1 == "off" ]];
then
	sudo umount /home/marko/Audio
	sudo umount /home/marko/Documents
	sudo umount /home/marko/Downloads/Dump
	sudo umount /home/marko/Downloads/Torrent
	sudo umount /home/marko/Games
	sudo umount /home/marko/Video
elif [[ $1 == "on" ]];
then
	sshfs marko@server-mystic:/home/marko/Primary/Audio ~/Audio
	sshfs marko@server-mystic:/home/marko/Primary/Documents ~/Documents
	sshfs marko@server-mystic:/home/marko/Primary/Dump ~/Downloads/Dump
	sshfs marko@server-mystic:/home/marko/Primary/Games ~/Games
	sshfs marko@server-mystic:/home/marko/Primary/Services/Torrent ~/Downloads/Torrent
	sshfs marko@server-mystic:/home/marko/Primary/Video ~/Video
else
	echo "Please use 'add' or 'remove' parameter.";
	exit 1
fi

exit 0;

