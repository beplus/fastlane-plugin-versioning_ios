require 'spec_helper'

describe Fastlane::Actions::IosGetVersionAction do
  describe "Get Version" do
    before do
      copy_project_files_fixture
    end

    it "should return Version from Xcode project file" do
      result = Fastlane::FastFile.new.parse('lane :test do
        ios_get_version
      end').runner.execute(:test)
      expect(result).to eq("1.23.4")
    end

    it "should set Version to IOS_VERSION shared value" do
      Fastlane::FastFile.new.parse('lane :test do
        ios_get_version
      end').runner.execute(:test)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IOS_VERSION]).to eq("1.23.4")
    end

    after do
      remove_project_files_fixture
    end
  end
end
