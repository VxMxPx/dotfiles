#!/bin/bash

# Net enable / disable
# Example net.sh on | net.sh off

if [ "x$1" == "xon" ]; then
	# Will ENABLE access for users!
	curl --user :maarko --data "submit_button=Filters&change_action=&submit_type=save&action=Apply&blocked_service=&filter_web=&filter_policy=&f_status=0&f_id=2&f_status1=disable&f_name=PTX&f_status2=deny&day_all=1&time_all=1&allday=" http://192.168.1.1/apply.cgi > /dev/null
	echo -e "\nUsers access ENABLED!"
elif [ "x$1" == "xoff" ]; then
	# Will DISABLE access for users!
	curl --user :maarko --data "submit_button=Filters&change_action=&submit_type=save&action=Apply&blocked_service=&filter_web=&filter_policy=&f_status=1&f_id=2&f_status1=enable&f_name=PTX&f_status2=deny&day_all=1&time_all=1&allday=" http://192.168.1.1/apply.cgi > /dev/null
	echo -e "\nUsers access DISABLED!"
else
	echo -e "\nWhat are you doing? Use on/off."
fi
