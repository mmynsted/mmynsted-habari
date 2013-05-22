Puppet module for Habari
==================================

This puppet module is used to install [Habari](http://habariproject.org "Habari").  
Habari is a PHP based, online publishing platform. 

Basic use
---------

0. Ensure a web server with php and other dependencies are installed as required by Habari.
   A working example can be found [here](#).  *Perhaps a future enhancement would be to automatically 
   install a web server.*

0. Ensure an applicable database is installed and identify credentials, schema and other information 
   for use by Habari.

        #create a data source
        class { 'habari::mysql':
           root_password        => 'vagrant',
           schema               => 'habari',
           user                 => 'vagrant',
           password             => 'vagrant',
           host                 => 'localhost',
           prefix               => 'habari__',
        }

0. Ensure habari site code is installed.

        #install code
        class { 'habari':
           db_template_head     => $habari::mysql::template_head,
           version              => '0.9',
           admin_username       => 'admin',
           admin_pass           => 'vagrant',
        }
   Note: The ``db_template_head`` must match the database used for Habari.  Above ``mysql`` was used so 
   ``db_template_head`` was set to ``$habari::mysql::template_head``.  *At the time of this writing **mysql** is 
   the only choice*.
   

Dependencies
------------

### Modules

* ``puppetlabs/stlib``            >= 2.2.1
* ``smarchive/puppet-archive``    >= 0.1.1
* ``puppetlabs/puppetlabs-mysql`` >= 0.6.1


### Other

* Some form of web server 
* Various PHP packages

Notes
-----

This module was designed specifically to install Habari in a CentOS based virtual machine.

Contributers
------------

* The creators of and contributers to Habari
* [Mark Mynsted](https://github.com/mmynsted)
* You?

Copyright and License
---------------------

Copyright (c) 2013 Growing Liberty LLC

Growing Liberty can be contacted via the [contact](https://growingliberty.com/contact "contact us") page.

         Licensed under the Apache License, Version 2.0 (the "License");
         you may not use this except in compliance with the License.
         You may obtain a copy of the License at
         
           http://www.apache.org/licenses/LICENSE-2.0
         
         Unless required by applicable law or agreed to in writing, software
         distributed under the License is distributed on an "AS IS" BASIS,
         WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
         See the License for the specific language governing permissions and
         limitations under the License.


[GrowingLiberty.com](http://growingliberty.com "growingliberty.com")

Support
-------

Please log tickets and issues at our [Projects site](https://github.com/mmynsted/mmynsted-habari "mmynsted-habari GitHub site").
