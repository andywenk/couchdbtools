require 'spec_helper'

describe Couchdbtools::Api::Database do
  before do
    Couchdbtools.setup
    Couchdbtools.database.create('couchdbtools-test')
  end

  it "expects to create the database couchdbtools-test" do
    expect(Couchdbtools.database.get('couchdbtools-test')).to have_key :db_name
    expect(Couchdbtools.database.get('couchdbtools-test')).to have_value 'couchdbtools-test'
  end

  it "expects to delete the database couchdbtools-test" do
    response = Couchdbtools.database.delete('couchdbtools-test')
    expect(response).to have_key :ok
    expect(response).to have_value true
  end

  it "expects to get " do
    pending "implement me!"
  end
end
