module Fastlane
  module Actions
    module SharedValues
      IOS_NEW_VERSION = :IOS_NEW_VERSION
    end

    class IosSetVersionAction < Action
      # More information about how to set up your project and how it works:
      # https://developer.apple.com/library/ios/qa/qa1827/_index.html
      # Attention: This is NOT the Version - but the Build Number

      def self.run(params)
        xcodeproj = params[:xcodeproj]
        version = params[:version]

        command_get = Helper::VersioningIosHelper.get_version_command(xcodeproj)
        command_set = Helper::VersioningIosHelper.set_version_command(xcodeproj, version)
        Helper::VersioningIosHelper.is_agv_enabled(xcodeproj)

        if Helper.test?
          `#{command_set}`
          new_version = `#{command_get}`
        else
          (Actions.sh command_set)
          new_version = (Actions.sh command_get)
        end

        new_version = Helper::VersioningIosHelper.parse_version(new_version)

        UI.success("👍  Version has been set to: #{new_version}")

        # Store the Version in the shared hash
        Actions.lane_context[SharedValues::IOS_NEW_VERSION] = new_version
      end

      def self.description
        "Set the Version of your iOS project"
      end

      def self.details
        [
          "This action will set the new Version on your iOS project.",
          "You have to set up your Xcode project to use AGV. For more info:",
          "https://developer.apple.com/library/ios/qa/qa1827/_index.html"
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :version,
                                  env_name: "FL_IOS_SET_VERSION_VERSION",
                               description: "Change to a specific Version",
                                  optional: true,
                                 is_string: true),
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                  env_name: "FL_IOS_SET_VERSION_XCODEPROJ",
                               description: "(optional) Specify the path to your main Xcode project if it isn't in the project root directory",
                                  optional: true,
                              verify_block: proc do |value|
                                UI.user_error!("Please specify the path to the project, not workspace") if value.end_with? ".xcworkspace"
                                UI.user_error!("Could not find Xcode project") unless File.exist?(value)
                              end)
        ]
      end

      def self.output
        [
          ['IOS_NEW_VERSION', 'The new Version of your iOS project']
        ]
      end

      def self.return_value
        "The new Version of your iOS project"
      end

      def self.authors
        ["Igor Lamoš"]
      end

      def self.is_supported?(platform)
        [:ios].include? platform
      end

      def self.example_code
        [
          'ios_set_version(
            version: "1.23.4" # Set a specific version
          )',
          'ios_set_version(
            version: "1.23.4", # Set a specific version
            xcodeproj: "/path/to/Project.xcodeproj" # Xcode project is not in the project root directory
          )'
        ]
      end
    end
  end
end
