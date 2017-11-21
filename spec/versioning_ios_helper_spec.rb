require 'spec_helper'

describe Fastlane::Helper::VersioningIosHelper do
  describe "Versioning iOS Helper" do
    it "should return path to Xcode project" do
      result = Fastlane::Helper::VersioningIosHelper.get_xcodeproj(nil)
      expect(result).to eq(Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST)
    end

    it "should return absolute folder with Xcode project" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      result = Fastlane::Helper::VersioningIosHelper.get_xcodeproj_path(xcodeproj)
      expect(result).to eq("/tmp/fastlane/tests/versioning")
    end

    it "should create the command for getting version" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      result = Fastlane::Helper::VersioningIosHelper.get_version_command(xcodeproj)
      expect(result).to eq("cd /tmp/fastlane/tests/versioning && agvtool what-marketing-version -terse1")
    end

    it "should create the command for setting new version" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      version = "1.23.4"
      result = Fastlane::Helper::VersioningIosHelper.set_version_command(xcodeproj, version)
      expect(result).to eq("cd /tmp/fastlane/tests/versioning && agvtool new-marketing-version #{version}")
    end

    it "should create the command for getting build number" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      result = Fastlane::Helper::VersioningIosHelper.get_build_number_command(xcodeproj)
      expect(result).to eq("cd /tmp/fastlane/tests/versioning && agvtool what-version -terse")
    end

    it "should create the command for setting new (increment) build number" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      build_number = nil
      result = Fastlane::Helper::VersioningIosHelper.set_build_number_command(xcodeproj, build_number)
      expect(result).to eq("cd /tmp/fastlane/tests/versioning && agvtool next-version -all")
    end

    it "should create the command for setting new (specific) build number" do
      xcodeproj = Fastlane::Helper::VersioningIosHelper::XCODEPROJ_TEST
      build_number = "17"
      result = Fastlane::Helper::VersioningIosHelper.set_build_number_command(xcodeproj, build_number)
      expect(result).to eq("cd /tmp/fastlane/tests/versioning && agvtool new-version -all #{build_number}")
    end
  end
end
