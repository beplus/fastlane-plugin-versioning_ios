module Fastlane
  module Actions
    module SharedValues
      IOS_NEW_BUILD_NUMBER = :IOS_NEW_BUILD_NUMBER
    end

    class IosSetBuildNumberAction < Action
      # More information about how to set up your project and how it works:
      # https://developer.apple.com/library/ios/qa/qa1827/_index.html
      # Attention: This is NOT the Version - but the Build Number

      def self.run(params)
        xcodeproj = params[:xcodeproj]
        build_number = params[:build_number]

        command_get = Helper::VersioningIosHelper.get_build_number_command(xcodeproj)
        command_set = Helper::VersioningIosHelper.set_build_number_command(xcodeproj, build_number)
        Helper::VersioningIosHelper.is_agv_enabled(xcodeproj)

        if Helper.test?
          `#{command_set}`
          new_build_number = `#{command_get}`
        else
          (Actions.sh command_set)
          new_build_number = (Actions.sh command_get)
        end

        new_build_number = Helper::VersioningIosHelper.parse_build_number(new_build_number)

        UI.success("👍  Build Number has been set to: #{new_build_number}")

        # Store the Build Number in the shared hash
        Actions.lane_context[SharedValues::IOS_NEW_BUILD_NUMBER] = new_build_number
      end

      def self.description
        "Set the Build Number of your iOS project"
      end

      def self.details
        [
          "This action will set the new Build Number on your iOS project.",
          "You have to set up your Xcode project to use AGV. For more info:",
          "https://developer.apple.com/library/ios/qa/qa1827/_index.html"
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :build_number,
                                  env_name: "FL_IOS_SET_BUILD_NUMBER_BUILD_NUMBER",
                               description: "Change to a specific Build Number",
                                  optional: true,
                                 is_string: false),
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                  env_name: "FL_IOS_SET_BUILD_NUMBER_XCODEPROJ",
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
          ['IOS_NEW_BUILD_NUMBER', 'The new Build Number of your iOS project']
        ]
      end

      def self.return_value
        "The new Build Number of your iOS project"
      end

      def self.authors
        ["Igor Lamoš"]
      end

      def self.is_supported?(platform)
        [:ios].include? platform
      end

      def self.example_code
        [
          'ios_set_build_number # Automatically increment by one',
          'ios_set_build_number(
            build_number: "17" # Set a specific number
          )',
          'ios_set_build_number(
            build_number: "17",
            xcodeproj: "/path/to/Project.xcodeproj" # Xcode project is not in the project root directory
          )',
          'build_number = ios_set_build_number # Save returned Build Number to a variable'
        ]
      end
    end
  end
end
