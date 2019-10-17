FRAMEWORK_NAME=GXUIKitExtensions
WORKSPACE_NAME=GXUIKitExtensions
SCHEME_NAME=GXUIKitExtensions

iOS_ARCHIVE_PATH=/tmp/xcf/${FRAMEWORK_NAME}/ios.xcarchive
DERIVED_DATA_PATH=/tmp/${FRAMEWORK_NAME}/iphoneos
iOS_SIMULATOR_ARCHIVE_PATH=/tmp/xcf/${FRAMEWORK_NAME}/iossimulator.xcarchive


OUTPUT_DIR=$(PWD)/../../xcframeworks
echo $iOS_ARCHIVE_PATH
echo $(PWD)

xcodebuild archive -scheme ${SCHEME_NAME} -destination="iOS" -archivePath ${iOS_ARCHIVE_PATH} -derivedDataPath ${DERIVED_DATA_PATH} -sdk iphoneos  SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme ${SCHEME_NAME} -destination="iOS Simulator" -archivePath ${iOS_SIMULATOR_ARCHIVE_PATH} -derivedDataPath ${DERIVED_DATA_PATH} -sdk iphonesimulator  SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

### DELETE OLD FRAMEWORK
rm -rf ${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework

xcodebuild -create-xcframework -framework ${iOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework -framework ${iOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework -output ${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework
