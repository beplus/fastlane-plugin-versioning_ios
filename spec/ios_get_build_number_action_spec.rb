require 'spec_helper'

describe Fastlane::Actions::IosGetBuildNumberAction do
  describe "Get Build Number" do
    before do
      copy_project_files_fixture
    end

    it "should return Build Number from Xcode project file" do
      result = Fastlane::FastFile.new.parse('lane :test do
        ios_get_build_number
      end').runner.execute(:test)
      expect(result).to eq("17")
    end

    it "should set Build Number to IOS_BUILD_NUMBER shared value" do
      Fastlane::FastFile.new.parse('lane :test do
        ios_get_build_number
      end').runner.execute(:test)
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IOS_BUILD_NUMBER]).to eq("17")
    end

    after do
      remove_project_files_fixture
    end
  end
end
