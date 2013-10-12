require 'spec_helper'

# before do
#   @dog = AwesomeGem::Awesome.new(name: 'woofer!')
# end
# it 'should have a name' do
#   @dog.name.should eq 'woofer!'
# end
# context '#lick_things' do
#   it 'should return the dog\'s name in a string' do
#     @dog.lick_things.should include 'woofer!:'
#   end
# end


describe Couchdbtools::Database do
  before do
    Couchdbtools.setup
  end

  it "should create the database couchdbtools-test" do
    Couchdbtools.database.create('couchdbtools-test')
    Couchdbtools.database.get('couchdbtools-test').values.should include("couchdbtools-test")
    Couchdbtools.database.delete('couchdbtools-test')
  end

  it "should get info about a database" do
    pending
  end

end
