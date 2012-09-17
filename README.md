rundeck-mcollective-nodes
=======

Resource Model Source Provider Script Plugin

This plugin will make use of an underlying MCollective Installation by exploiting the mco utility

The interface currently implemented is:

    mco rpc rpcutil -j inventory

Optionally if mongodb is supported, the following may be used which shall significantly increase performance when generating the reosurce model:

    mco rpc --dm mongo rpcutil -j inventory

in order for this plugin to function, the MCollective Client must be installed and configured, for example the mco utility is owned by the mcollective-client rpm package:

   [chuck@stubhub-centos62-64-vm6 rundeck-mcollective-nodes]$ rpm -qf /usr/bin/mco
   mcollective-client-2.2.0-1.el6.noarch


See the following regarding mcollective and optional mongodb support:

http://docs.puppetlabs.com/mcollective/reference/basic/gettingstarted.html

http://docs.puppetlabs.com/mcollective/reference/plugins/registration.html

http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentRegistrationMongoDB

Additionally, json/ruby support must exist, which is needed to transform derived json data to resourcexml format.
This is typically provided by the ruby json gem and is installed/verified like so:

    [chuck@stubhub-centos62-64-vm6]$   sudo gem install json

    [chuck@stubhub-centos62-64-vm6]$   gem list json
    *** LOCAL GEMS ***
    json (1.7.5)
