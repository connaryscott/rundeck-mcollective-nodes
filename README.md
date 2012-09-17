rundeck-mcollective-nodes
=======

Resource Model Source Provider Script Plugin

This plugin will make use of an underlying MCollective Installation by exploiting the mco utility

The interface currently implemented is:

   mco rpc rpcutil -j inventory

Optionally if mongodb is supported, the following may be used which shall significantly increase performance when generating the reosurce model:

   mco rpc --dm mongo rpcutil -j inventory

in order for this plugin to function, the MCollective Client must be installed, for example the mco utility is owned by the mcollective-client rpm package:

   [chuck@stubhub-centos62-64-vm6 rundeck-mcollective-nodes]$ rpm -qf /usr/bin/mco
   mcollective-client-2.2.0-1.el6.noarch

Additionally, json/ruby support must exist, which is typically provided by the ruby json gem and installed/verified like so:

   [chuck@stubhub-centos62-64-vm6]$   sudo gem install json

   [chuck@stubhub-centos62-64-vm6]$   gem list json
   *** LOCAL GEMS ***
   json (1.7.5)

Other assumptions are made that is consistent with an MCollective Installation  and optional MongoDB Support
