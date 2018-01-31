require "spec_helper"

# to run specs with what"s remembered from vcr
#   $ rake
#
# to run specs with new fresh data from aws api calls
#   $ rake clean:vcr ; time rake
describe AwsRds::CLI do
  before(:all) do
    @args = "--noop"
  end

  describe "aws-rds" do
    it "create" do
      out = execute("exe/aws-rds create mydb #{@args}")
      expect(out).to include("Creating")
    end
  end
end
