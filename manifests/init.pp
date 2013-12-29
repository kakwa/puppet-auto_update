# == Class: auto_update
#
# A very simple module dumping an auto update, non interactive script in cron.daily.
#
# You must have cron installed.
#
# It relies on:
# * yum for RedHat and derivatives
# * aptitude for Debian and derivatives
#
# === Parameters
#
# Just two optional parameters: 
#
# [*update_window*]
#   
#  This parameter is used for randomizing the update time.
#  If you have several OSes it will prevent all the OSes 
#  from updating at the same time by just sleep a random number of
#  seconds between 0 and <update_window>.
#
#  Default value is 3600 seconds (1 hour).
#
#  Set to 0 to disable.
# 
# [*log_updated_packages*]
#
#  The parameter `log_updated_packages` is used to log to syslog each updated packages.
# 
#  It could be useful to easily track what was updated, specialy if something broke.
# 
#  Values are 'true' or 'false'.
# 
#  Default is 'false', it will only log start of the update and the
#  result according to the return code of the update command.
# 
#  Currently log_updated_packages only works on aptitude based distribution.
#
# === Examples
#
#  # with the default random window (3600 seconds)
#  import auto_update
#
#  # with a random sleep between 0 and 1337 seconds
#  class { auto_update:
#    update_window => '1337',
#  }
#  
#  # without a random sleep
#  class { auto_update:
#    update_window => '0',
#  }
#
#  # with updated packages logs enabled
#  class { auto_update:
#    log_updated_packages => 'true',
#  }
#
# === Authors
#
# Carpentier Pierre-Francois <carpentier.pf@gmail.com>
#
# === Copyright
#
# Copyright 2013 Carpentier
#
# License: MIT 
#
class auto_update(
    $update_window = '3600',
    $log_updated_packages = 'false',
)
inherits auto_update::params{
    # we just put a simple script in cron.daily
    file{ "${auto_update::params::cron_daily_dir}/pkg_auto_update":
        content => template("${module_name}/auto_update.sh.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    } 
}
