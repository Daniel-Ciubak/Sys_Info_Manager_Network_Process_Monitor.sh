#!/bin/bash
export DISPLAY=:0
echo "take option"
echo "1.clean temp and printer jobs"
echo "2.info about networking like ipv4,mac address,gateway,genmask,other"
echo "3.info about cpu gpu ram and memory"
echo "4.info about active and system process"
echo "5.exit the program"
echo "6.remove active process"

read action
case "$action" in
1)
#clean temp
find /tmp -type f -delete >/dev/null 2>&1 

#clean printerjob in spool
cancel -a

echo "temp and printjobs to be delete"
;;

2)
#info about network device && protocols && source addresses && metric
ip route show

echo
#info about flags && mtu(Maximum Transmission Unit) && inet inet6 && 
#ether(Interface MAC address) && RX/TX packets
ip addr show

echo
#info about gateway && genmask && Destination && iface(network interface) &&
#Window(TCP window size) && irtt (Initial Round-Trip Time)
netstat -rt


;;

3)
#check cpu level
mpstat
vmstat

echo

#check ram level
free -h

echo

#check memory(gb) level
df -h

echo

#check gpu level
lshw -C display

;;

4)
#check active and system process
ps -aux
;;

5)
exit 0
;;

6)
echo "take process what u want close"
read pid
if [[ ! $pid =~ ^[0-9]+$ ]]; then
echo "pid must be a number"
exit 1
fi

if ! ps -p $pid > /dev/null 2>&1; then
echo "no find pid number"
echo 1
fi

if [[ $EUID -ne 0  ]]; then
echo "no permission to close this process"
exit 1
fi 


if kill -15 $pid 2>/dev/null; then
echo "process number pid $pid is removed"
exit 0

else echo "can't close process check your permission"
fi
;;


*)
echo "wrong choice take other option :)"
;;
esac

-------------------------
crontab -e
49 22 * * * sh -c 'export DISPLAY=:0; dbus-launch gnome-terminal -- /home/herorich/skrypty/Sys_Info_Manager_Network_Process_Monitor.sh'



