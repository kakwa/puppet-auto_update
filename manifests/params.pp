#some specific os variables

class auto_update::params {
    case $::osfamily {
        #Debian family variables
        'Debian': {
            $cron_daily_dir = '/etc/cron.daily/'
            $update_command = 'aptitude clean; aptitude update; DEBIAN_FRONTEND=noninteractive aptitude upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"  -f -q -y'
            $updated_packages_command = 'grep "^`date +%F`" /var/log/dpkg.log |grep " upgrade \| install "|awk \'{print "package update: "$4" (old:"$5") (new:"$6")"}\''
        }
        
        #RedHat family variables
        'RedHat': {
            $cron_daily_dir = '/etc/cron.daily/'
            $update_command = 'yum clean all;yum update -y'
            $updated_packages_command = 'rpm -qa --last|grep "`date +\'%a %d %b %Y\'`"|awk \'{print "package update: "$1;}\''
        }
    }
}
