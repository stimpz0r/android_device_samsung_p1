#!/tmp/busybox sh

HW=$(busybox cat /proc/cpuinfo | busybox grep Hardware | busybox sed s/Hardware// | busybox tr '[A-Z]' '[a-z]' | busybox tr -d ' ' | busybox tr -d ':' | busybox tr -d '\t')
DEVICE=$(busybox cat /default.prop | busybox grep ro.cm.device | busybox sed s#ro\.cm\.device=## | busybox tr '[A-Z]' '[a-z]')

case $HW in
p1|gt-p1000)
	model=p1
;;
p1l|gt-p1000l|p1n|gt-p1000n|p1ln)
	model=p1ln
;;
*)
echo "Invalid model: $HW"
exit 2
;;
esac

if [ "$model" == "p1" ] ; then
case $DEVICE in
p1)
;;
p1l|p1n)
	model=p1ln
;;
*)
	echo "Invalid device: $DEVICE"
;;
esac
fi

if [ "$model" != "p1" ] ; then
busybox rm /tmp/boot.img
busybox mv /tmp/boot_$model.img /tmp/boot.img
fi

exit 0
