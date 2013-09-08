#!/usr/bin/env ruby

# run bundle install
# run this script with bundle exec ruby test.rb
# uncomment the commands you wanna fire
# and make sure you have a CouchDB instance running ;-)

require 'couchdbtools'

Couchdbtools.setup

#puts Couchdbtools.database.create('moonbeans')
#puts Couchdbtools.database.all_docs('moonbeans')

#puts Couchdbtools.database.delete('moonbeans')
#puts Couchdbtools.database.all_dbs

#documents = Couchdbtools.document
#documents.put({id: 'x0043', name: 'harry belafonte'})

# documents.put({id: 'x0043', _rev: '1-19f138f135ddb4c6c2a7fdff4563844c', name: 'harry belafonte', age: 86})
# puts documents.get({id: 'x0043'})

#puts documents.post({:name => 'Jack Rabbit'})
#puts documents.get({id: "04e5e5f7e36a2ee255791e66a1d05bf4"})

#puts Couchdbtools.document.all_docs

#puts Couchdbtools.uuids
