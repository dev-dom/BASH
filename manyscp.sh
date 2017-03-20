#! /bin/sh
echo  "Enter root password and press [ENTER]: "
stty -echo
read pass
stty echo
export pass
 
echo "Copying the file"
SCRIPT='
	package require Tcl 8.4
	package require Expect 5.40
	set HOSTS "host1 host2 host3 host4"
	foreach host $HOSTS {
				spawn sh -c "scp -C -o StrictHostKeyChecking=no ./filename.txt root@$host:/tmp";
				sleep 3;
				expect "*?assword:*"
				send -- "$env(pass)\r"
				expect 100%
				send -- "exit\r"
				expect eof
			}
'
/usr/bin/expect << HERE
$SCRIPT
# NOTE 1
# You can Hardcode the password with the below code [BAD PRACTICE]
# pass="password"
# export pass
 
# NOTE 2
# You can also provide the list of hosts to connect from a file within the expect routine
# set f [open "./HostsUserFile.txt" r]
# set hosts [split [read -nonewline $f] "\n"]
# close $f
