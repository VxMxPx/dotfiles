# Crackling and popping sound when using headphones

https://wiki.archlinux.org/index.php/ASUS_Zenbook_UX430/UX530#Headphones_audio_is_too_low

/usr/local/bin/fix_headphones_audio.sh

```
#!/bin/bash
while true; do
	DEVICE=`ls /dev/snd/hwC[[:print:]]*D0 | head -n 1`
	if [ ! -z "$DEVICE" ]; then
		hda-verb "$DEVICE" 0x20 SET_COEF_INDEX 0x67
		hda-verb "$DEVICE" 0x20 SET_PROC_COEF 0x3000
		break
	fi
	sleep 1
done
```

/etc/systemd/system/fix_headphones_audio.service

```
[Unit]
Description=Fix headphones audio after boot & resume.
After=multi-user.target suspend.target hibernate.target

[Service]
Type=oneshot
ExecStart=/bin/sh '/usr/local/bin/fix_headphones_audio.sh'

[Install]
WantedBy=multi-user.target suspend.target hibernate.target
```

And finally, start and enable fix_headphones_audio.service.