module Fastlane
  module Actions
    module SharedValues
      IOS_VERSION = :IOS_VERSION
    end

    class IosGetVersionAction < Action
      # More information about how to set up your project and how it works:
      # https://developer.apple.com/library/ios/qa/qa1827/_index.html
      # Attention: This is NOT the Version - but the Build Number

      def self.run(params)
        xcodeproj = params[:xcodeproj]

        command_get = Helper::VersioningIosHelper.get_version_command(xcodeproj)
        Helper::VersioningIosHelper.is_agv_enabled(xcodeproj)

        version = Helper.test? ? `#{command_get}` : (Actions.sh command_get)
        version = Helper::VersioningIosHelper.parse_version(version)

        UI.success("👍  Current Version is: #{version}")

        # Store the Version in the shared hash
        Actions.lane_context[SharedValues::IOS_VERSION] = version
      end

      def self.description
        "Get the Version of your iOS project"
      end

      def self.details
        [
          "This action will return current Version of your iOS project.",
          "You have to set up your Xcode project to use AGV. For more info:",
          "https://developer.apple.com/library/ios/qa/qa1827/_index.html"
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                  env_name: "FL_IOS_GET_VERSION_XCODEPROJ",
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
          ['IOS_VERSION', 'The Version of your iOS project']
        ]
      end

      def self.return_value
        "The Version of your iOS project"
      end

      def self.authors
        ["Igor Lamoš"]
      end

      def self.is_supported?(platform)
        [:ios].include? platform
      end

      def self.example_code
        [
          'build_number = ios_get_version # Xcode project is in the project root directory',
          'build_number = ios_get_version(xcodeproj: "/path/to/Project.xcodeproj")'
        ]
      end
    end
  end
end
