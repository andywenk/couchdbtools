# Couchdbtools

Yet another CouchDB wrapper? Oh my! But wait. This my approach to create a very simple 
API to run against CouchDB. The target is to map the RESTful CouchDB API so that
it's possible to use the one from the gem here intuitively. 

This is version 0.0.2 

## Installation

Add this line to your application's Gemfile:

    gem 'couchdbtools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install couchdbtools

## Usage

Here are some very basic examples.

### Server

#### GET

##### all existing databases
    
    Couchdbtools.setup
    Couchdbtools.server.all_dbs
    _replicator
    _users

### Database

#### PUT

##### create a new database

    Couchdbtools.setup
    Couchdbtools.database.create('moonbeans')
    {:ok=>true}

#### DELETE

##### delete an existing database

    Couchdbtools.setup
    Couchdbtools.database.delete('moonbeans')
    {:ok=>true}

### Documents

#### POST
    
##### create a new document

    Couchdbtools.setup
    documents = Couchdbtools.document
    documents.post({name: 'Jack Rabbit'})
    {:ok=>true, :id=>"04e5e5f7e36a2ee255791e66a1d05bf4", :rev=>"1-dc938c4200ba911d7eb9016273192412"}

#### GET

##### get a document

    Couchdbtools.setup
    documents = Couchdbtools.document
    documents.get({id: "04e5e5f7e36a2ee255791e66a1d05bf4"})
    {:_id=>"04e5e5f7e36a2ee255791e66a1d05bf4", :_rev=>"1-dc938c4200ba911d7eb9016273192412", :name=>"Jack Rabbit"}

#### PUT

##### create a new document

    Couchdbtools.setup
    documents = Couchdbtools.document
    documents.put({id: 'x0043', name: 'harry belafonte'})
    {:ok=>true, :id=>"x0043", :rev=>"1-19f138f135ddb4c6c2a7fdff4563844c"}

##### update an existing document

    Couchdbtools.setup
    documents.put({id: 'x0043', _rev: '1-19f138f135ddb4c6c2a7fdff4563844c', name: 'harry belafonte', age: 86})
    {:ok=>true, :id=>"x0043", :rev=>"2-92a0d1ea9f15d1cc046455482bafe3fc"}
    documents.get({id: 'x0043'})
    {:_id=>"x0043", :_rev=>"2-92a0d1ea9f15d1cc046455482bafe3fc", :name=>"harry belafonte", :age=>86}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/andywenk/couchdbtools/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

