auto_update
===========

A puppet module setting-up daily auto-update your Debian/CentOS (or any yum/aptitude based distribution).

Blind update is risky, if you use this module in production, you're crazy ☺. But it could ease maintenance of non-critical infrastructures (like your developpement platforms).

Description
-----------

auto_update is a very simple module dumping an auto update, non-interactive, script in cron.daily directory.

It relies on:

* yum for RedHat and derivatives
* aptitude for Debian and derivatives
* cron

As this module is extremly simple and very specific, it will not handle those dependancies, they must be installed otherwise.

Supported OSes
--------------

* Debian and derivatives
* RedHat and derivatives

Examples
--------

```puppet

 # with the default random window (3600 seconds)
 import auto_update

 # with a random sleep between 0 and 1337 seconds
 class { auto_update:
   update_window => '1337',
 }
 
 # without a random sleep
 class { auto_update:
   update_window => '0',
 }

 # log to syslog updated packages
 class { auto_update:
   log_updated_packages => 'true',
 }

```

Parameters
----------

Just two optional parameters: `update_window` and `log_updated_packages`

  
The parameter `update_window` is used for randomizing the update time.
 
If you have several OSes, it will prevent all the OSes 
from updating at the same time by just sleeping a random number of
seconds between `0` and `$update_window`.

Default value is 3600 seconds (1 hour).

Set to `0` to disable (if you use anacron for example).

The parameter `log_updated_packages` is used to log to syslog each updated packages.

It could be useful to easily track what was updated, specialy if something broke.

Values are `'true'` or `'false'`.

Default is `'false'`, it will only log start of the update and the 
result according to the return code of the update command.

Launch manually
---------------

You can lauch this script manually:

```bash
root@your_host > /etc/cron.daily/pkg_auto_update -h
usage: pkg_auto_update [-h] [-l] [-n]

Auto update script
arguments:
  -h: displays this help
  -l: enables updated packages logs (already enabled: false)
  -n: update now, no sleep

root@your_host > /etc/cron.daily/pkg_auto_update -n -l
``` 

Authors
-------

Carpentier Pierre-Francois <carpentier.pf@gmail.com>

Copyright
---------

Copyright 2013 Carpentier Pierre-Francois <carpentier.pf@gmail.com>

License
-------

This module is released under MIT public license. 
