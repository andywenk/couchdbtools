require 'spec_helper'

describe Couchdbtools::Api::Server do
  before do
    Couchdbtools.setup
  end

  it "expects the answer to be an Array" do
    expect(Couchdbtools.server.active_tasks).to be_an_instance_of Array
  end

  it "expects to return all available databases" do
    expect(Couchdbtools.server.all_dbs).to include  "_replicator"
    expect(Couchdbtools.server.all_dbs).to include  "_users"
  end

  it "expects the answer to have key uuids" do
    expect(Couchdbtools.server.uuids).to have_key :uuids
  end

  it "expects db_updates" do
    fork do
      Couchdbtools.database.create('db_updates_test')
      Couchdbtools.database.delete('db_updates_test')
      exit
    end
    expect(Couchdbtools.server.db_updates({timeout: 20})).to have_key :db_name
  end

  it "expects to return a log" do
    Couchdbtools.database.create('log_test')
    Couchdbtools.database.delete('log_test')
    expect(Couchdbtools.server.log).to match /DELETE \/log_test/
  end

  it "expect to replicate from local database a to b" do
    Couchdbtools.database.create('replicate_test_a')
    replication = Couchdbtools.server.replicate({source: 'replicate_test_a', target: 'replicate_test_b', create_target: true})
    expect(replication).to have_key :ok
    expect(replication).to have_value true
    Couchdbtools.database.delete('replicate_test_a')
    Couchdbtools.database.delete('replicate_test_b')
  end

  it "expects to show stats" do
    stats = Couchdbtools.server.stats
    expect(stats).to have_key :couchdb
  end

  it "expects to return uuids" do
    expect(Couchdbtools.server.uuids).to have_key :uuids
  end

  # this test must come last!!!
  it "expects a successfull restart" do
    restart = Couchdbtools.server.restart
    expect(restart).to have_key :ok
    expect(restart).to have_value true
  end
end
