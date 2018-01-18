require "spec_helper"

# to run specs with what"s remembered from vcr
#   $ rake
#
# to run specs with new fresh data from aws api calls
#   $ rake clean:vcr ; time rake
describe AwsRds::CLI do
  before(:all) do
    @args = "--from Tung"
  end

  describe "aws-rds" do
    it "should hello world" do
      out = execute("exe/aws-rds hello world #{@args}")
      expect(out).to include("from: Tung\nHello world")
    end
  end
end
