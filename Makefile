BUILD_DIR=${CURDIR}/build
BIN_DIR="${CURDIR}/bin"

LOVE_APP="/Applications/love.app"

GAME_NAME="boom"
GAME_PRETTY_NAME="Boom"
GAME_VERSION=$(shell cat version.txt)
GAME_PRETTY_VERSION=$(shell echo ${GAME_VERSION} | tr '_' '.')
GAME_IDENTIFIER="net.wolftrail.boom"

MAC_ICONS_PATH="${BUILD_DIR}/macOS/love-xcodeproj/platform/xcode/Images.xcassets/OS\ X\ AppIcon.appiconset"

run:
	love . #-play

clean: 
	# clean
	rm -rf -- "${BUILD_DIR}"
	mkdir -p "${BUILD_DIR}"

lovefile:
	# lovefile
	mkdir -p "${BUILD_DIR}"
	git archive --format zip HEAD > "${BUILD_DIR}/${GAME_NAME}.love"
	sh "${BIN_DIR}/zip-submodules.sh" "${BUILD_DIR}/${GAME_NAME}.love"

osx: clean lovefile
	# osx
	mkdir -p "${BUILD_DIR}/macOS"
	unzip "${BIN_DIR}/love-11.3-macOS.zip" -x "__MACOSX/*" -d "${BUILD_DIR}"
	mv "${BUILD_DIR}/love.app" "${BUILD_DIR}/macOS/${GAME_PRETTY_NAME}.app"

	cp "${BUILD_DIR}/${GAME_NAME}.love" "${BUILD_DIR}/macOS/${GAME_PRETTY_NAME}.app/Contents/Resources"
	$(eval INFO_PLIST := ${BUILD_DIR}/macOS/${GAME_PRETTY_NAME}.app/Contents/Info.plist)

	plutil -replace CFBundleIdentifier -string "${GAME_IDENTIFIER}" "${INFO_PLIST}"
	plutil -replace CFBundleName -string "${GAME_PRETTY_NAME}" "${INFO_PLIST}"
	plutil -remove UTExportedTypeDeclarations "${INFO_PLIST}"

	unzip "${BIN_DIR}/build-macos.zip" -x "__MACOSX/*" -d "${BUILD_DIR}/macOS"
	cp "${BUILD_DIR}/${GAME_NAME}.love" "${BUILD_DIR}/macOS/love-xcodeproj/platform/xcode/macosx/"

	$(eval INFO_PLIST := ${BUILD_DIR}/macOS/love-xcodeproj/platform/xcode/macosx/love-macosx.plist)
	plutil -insert CFBundleVersion -string "${GAME_PRETTY_VERSION}" "${INFO_PLIST}"
	plutil -replace CFBundleIdentifier -string "${GAME_IDENTIFIER}" "${INFO_PLIST}"
	plutil -replace CFBundleName -string "${GAME_PRETTY_NAME}" "${INFO_PLIST}"
	plutil -replace NSHumanReadableCopyright -string "© 2021 Wolftrail" "${INFO_PLIST}"
	plutil -replace CFBundleShortVersionString -string "${GAME_PRETTY_VERSION}" "${INFO_PLIST}"
	plutil -remove UTExportedTypeDeclarations "${INFO_PLIST}"
	plutil -remove CFBundleDocumentTypes "${INFO_PLIST}"

	unzip -o "${BIN_DIR}/icons.zip" -x "__MACOSX/*" -d "${MAC_ICONS_PATH}"
	rm "${MAC_ICONS_PATH}/icon.aseprite" "${MAC_ICONS_PATH}/48.png"

win: lovefile
	# win
	unzip "${BIN_DIR}/love-11.3-win32.zip" -x "__MACOSX/*" -d "${BUILD_DIR}/win32"
	cat "${BUILD_DIR}/win32/love.exe" "${BUILD_DIR}/${GAME_NAME}.love" > "${BUILD_DIR}/win32/${GAME_PRETTY_NAME}.exe"

	# Remove unnecessary files
	rm "${BUILD_DIR}/win32/changes.txt" "${BUILD_DIR}/win32/readme.txt"
	rm "${BUILD_DIR}/win32/game.ico" "${BUILD_DIR}/win32/love.ico"
	rm "${BUILD_DIR}/win32/love.exe" "${BUILD_DIR}/win32/lovec.exe"

	# Generate icons for Windows from PNG assets using ImageMagick convert utility
	unzip -o "${BIN_DIR}/icons.zip" -x "__MACOSX/*" -d "${BUILD_DIR}/win32"
	rm "${BUILD_DIR}/win32/icon.aseprite"
	convert "${BUILD_DIR}/win32/16.png" "${BUILD_DIR}/win32/32.png" "${BUILD_DIR}/win32/48.png" "${BUILD_DIR}/win32/64.png" "${BUILD_DIR}/win32/128.png" "${BUILD_DIR}/win32/256.png" "${BUILD_DIR}/win32/icon.ico"
	rm "${BUILD_DIR}/win32/"*.png

	# Extract windows specific files in build directory
	unzip "${BIN_DIR}/build-win32.zip" -x "__MACOSX/*" -d "${BUILD_DIR}/win32"

	# Update version number in resource file
	sed -i "" 's/1\.0\.0\.0/${GAME_PRETTY_VERSION}.0/' "${BUILD_DIR}/win32/VersionInfo.rc"

	# Run modify.bat script on Windows computer to update app metadata & icons

release: clean osx win	