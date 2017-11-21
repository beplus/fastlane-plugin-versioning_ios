module Fastlane
  module Helper
    class VersioningIosHelper
      require "shellwords"

      XCODEPROJ_TEST = "/tmp/fastlane/tests/versioning/Project.xcodeproj"

      def self.get_xcodeproj(xcodeproj)
        return Helper.test? ? XCODEPROJ_TEST : xcodeproj
      end

      def self.get_xcodeproj_path(xcodeproj)
        project_file = self.get_xcodeproj(xcodeproj)
        path = project_file ? File.join(project_file, "..") : "."
        return File.expand_path(path).shellescape
      end

      def self.get_version_command(xcodeproj)
        path = self.get_xcodeproj_path(xcodeproj)
        return [
          "cd", path, "&&", "agvtool", "what-marketing-version", "-terse1"
        ].join(" ")
      end

      def self.set_version_command(xcodeproj, version)
        path = self.get_xcodeproj_path(xcodeproj)
        version = self.parse_version(version)
        return [
          "cd", path, "&&", "agvtool", "new-marketing-version", version
        ].join(" ")
      end

      def self.get_build_number_command(xcodeproj)
        path = self.get_xcodeproj_path(xcodeproj)
        return [
          "cd", path, "&&", "agvtool", "what-version", "-terse"
        ].join(" ")
      end

      def self.set_build_number_command(xcodeproj, build_number)
        path = self.get_xcodeproj_path(xcodeproj)
        agvtool_command = build_number ? "new-version -all #{self.parse_build_number(build_number)}" : "next-version -all"
        return [
          "cd", path, "&&", "agvtool", agvtool_command
        ].join(" ")
      end

      def self.parse_version(version)
        # @todo SemVer check
        return version.to_s.strip
      end

      def self.parse_build_number(build_number)
        return build_number.to_s.strip
      end

      def self.is_agv_enabled(xcodeproj)
        # We do not want to run agvtool under tests to avoid
        # output about not having a project configured for AGV
        command_get = "#{self.get_version_command(xcodeproj)} > /dev/null 2>&1"
        unless Helper.test?
          agv_enabled = system(command_get)
          raise "Apple Generic Versioning (AGV) is not enabled." unless agv_enabled
        end
      end
    end
  end
end
