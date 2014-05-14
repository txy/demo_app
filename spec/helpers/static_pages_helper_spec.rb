require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the StaticPagesHelper. For example:
#
# describe StaticPagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      expect(full_title("foo")).to match(/foo/) 
    end

    it "should include the base title"  do
      expect(full_title("foo")).to match(/^Ruby on Rails Tutorial Demp App/) 
    end

    it "should not include a bar for the home page" do 
      expect(full_title("")).not_to match(/\|/) 
    end
  end
end
