Couchdbtools::Config
====================

You can define a configuration file in the `YAML <http://yaml.org/>`_ format. It is expeted in the root
directory of your application. The content should look something like this::

    # -*- encoding : utf-8 -*-
    #
    # configuration file for couchdbtools
    #
    app:
      logfile: './couchdbtools.log'

    db:
      host: 'localhost'
      name: 'kassenbuch'
      port: '5984'
      protocol: 'http'
