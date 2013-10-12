require 'spec_helper'

describe Couchdbtools do
  before do
    Couchdbtools.setup
  end

  it "expects an instance of Couchdbtools::Config" do
    expect(Couchdbtools.config).to be_an_instance_of(Couchdbtools::Config)
  end

  it "expects an instance of Couchdbtools::Server" do
    expect(Couchdbtools.server).to be_an_instance_of(Couchdbtools::Server)
  end

  it "expects an instance of Couchdbtools::Database" do
    expect(Couchdbtools.database).to be_an_instance_of(Couchdbtools::Database)
  end

  it "expects the answer to have key uuids" do
    expect(Couchdbtools.uuids).to have_key(:uuids)
  end

  it "should return all available databases" do
    Couchdbtools.setup
    Couchdbtools.server.all_dbs.should include  "_replicator"
    Couchdbtools.server.all_dbs.should include  "_users"
  end

end
