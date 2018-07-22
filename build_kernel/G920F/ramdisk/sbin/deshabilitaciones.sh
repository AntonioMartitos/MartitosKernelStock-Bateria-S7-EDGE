#!/system/bin/sh
#

# Set KNOX to 0x0 on running /system
/sbin/resetprop -n ro.boot.warranty_bit "0"
/sbin/resetprop -n ro.warranty_bit "0"

# Fix Safetynet flags
/sbin/resetprop -n ro.boot.veritymode "enforcing"
/sbin/resetprop -n ro.boot.verifiedbootstate "green"
/sbin/resetprop -n ro.boot.flash.locked "1"
/sbin/resetprop -n ro.boot.ddrinfo "00000001"
/sbin/resetprop -n ro.build.selinux "1"

# Fix Samsung Related Flags
/sbin/resetprop -n ro.fmp_config "1"
/sbin/resetprop -n ro.boot.fmp_config "1"
/sbin/resetprop -n sys.oem_unlock_allowed "0"

# Deepsleep fix
for i in `ls /sys/class/scsi_disk/`; do
	cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	if [ $? -eq 0 ]; then
		echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	fi
done

# SELinux Permissive / Enforcing Patch
# 0 = Permissive, 1 = Enforcing
echo "0" > /sys/fs/selinux/enforce
chmod 640 /sys/fs/selinux/enforce

