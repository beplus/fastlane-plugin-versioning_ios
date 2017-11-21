require 'spec_helper'

describe Fastlane::Actions::IosSetBuildNumberAction do
  describe "Set Build Number" do
    before do
      copy_project_files_fixture
    end

    it "should increment Build Number and return its new value" do
      result = Fastlane::FastFile.new.parse('lane :test do
        ios_set_build_number
      end').runner.execute(:test)
      expect(result).to eq("18")
    end

    it "should set incremented Build Number to IOS_NEW_BUILD_NUMBER shared value" do
      Fastlane::FastFile.new.parse('lane :test do
        ios_set_build_number
      end').runner.execute(:test)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IOS_NEW_BUILD_NUMBER]).to eq("18")
    end

    it "should set specific Build Number and return its new value" do
      result = Fastlane::FastFile.new.parse('lane :test do
        ios_set_build_number(build_number: 17)
      end').runner.execute(:test)
      expect(result).to eq("17")
    end

    it "should set specific Build Number to IOS_NEW_BUILD_NUMBER shared value" do
      Fastlane::FastFile.new.parse('lane :test do
        ios_set_build_number(build_number: 17)
      end').runner.execute(:test)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IOS_NEW_BUILD_NUMBER]).to eq("17")
    end

    after do
      remove_project_files_fixture
    end
  end
end
