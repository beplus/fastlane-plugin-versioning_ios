require 'spec_helper'

describe Fastlane::Actions::IosSetVersionAction do
  describe "Set Version" do
    before do
      copy_project_files_fixture
    end

    it "should set Version to specific value" do
      result = Fastlane::FastFile.new.parse('lane :test do
        ios_set_version(version: "2.34.5")
      end').runner.execute(:test)
      expect(result).to eq("2.34.5")
    end

    it "should set Version to IOS_NEW_VERSION shared value" do
      Fastlane::FastFile.new.parse('lane :test do
        ios_set_version(version: "2.34.5")
      end').runner.execute(:test)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IOS_NEW_VERSION]).to eq("2.34.5")
    end

    after do
      remove_project_files_fixture
    end
  end
end
