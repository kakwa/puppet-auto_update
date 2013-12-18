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
# Just one optional parameter: 
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
#
#
#  # without a random sleep
#  class { auto_update:
#    update_window => '0',
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
)
inherits auto_update::params{
    # we just put a simple script in cron.daily
    file{ "${auto_update::params::cron_daily_dir}/auto_update.sh":
        content => template("${module_name}/auto_update.sh.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    } 
}
