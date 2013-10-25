require 'spec_helper'

describe Couchdbtools::Api::Database do
  before do
    Couchdbtools.setup
  end

  it "should create the database couchdbtools-test" do
    Couchdbtools.database.create('couchdbtools-test')
    Couchdbtools.database.get('couchdbtools-test').values.should include("couchdbtools-test")
    Couchdbtools.database.delete('couchdbtools-test')
  end
end
