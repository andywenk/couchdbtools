require 'spec_helper'

describe Couchdbtools::Api::Server do
  before do
    Couchdbtools.setup
  end

  it "should return all available databases" do
    Couchdbtools.server.all_dbs.should include  "_replicator"
    Couchdbtools.server.all_dbs.should include  "_users"
  end

  it "expects the answer to have key uuids" do
    expect(Couchdbtools.server.uuids).to have_key(:uuids)
  end

  it "expects the answer to be an Array" do
    expect(Couchdbtools.server.active_tasks).to be_an_instance_of(Array)
  end

  it "expects db_updates" do
    pending "has to be implemented"
  end

  it "expects a log" do
    pending "has to be implemented"
  end

  it "should replicate" do
    pending "has to be implemented"
  end

  it "should restart" do
    pending "has to be implemented"
  end

  it "should show stats" do
    pending "has to be implemented"
  end
end
