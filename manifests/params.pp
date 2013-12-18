#some specific os variables

class auto_update::params {
    case $::osfamily {
        #Debian family variables
        'Debian': {
            $cron_daily_dir = '/etc/cron.daily/'
            $update_command = 'aptitude clean; aptitude update; DEBIAN_FRONTEND=noninteractive aptitude upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"  -f -q -y'
        }
        
        #RedHat family variables
        'RedHat': {
            $cron_daily_dir = '/etc/cron.daily/'
            $update_command = 'yum clean all;yum update -y'
        }
    }
}
