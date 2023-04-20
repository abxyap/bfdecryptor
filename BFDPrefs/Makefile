TARGET := iphone:clang:14.5:14.5

include $(THEOS)/makefiles/common.mk

THEOS_PACKAGE_SCHEME = rootless

BUNDLE_NAME = BFDPrefs

BFDPrefs_FILES =  BFDPRootListController.m
BFDPrefs_FRAMEWORKS = UIKit
BFDPrefs_PRIVATE_FRAMEWORKS = MobileCoreServices Preferences
BFDPrefs_EXTRA_FRAMEWORKS = AltList
BFDPrefs_INSTALL_PATH = /Library/PreferenceBundles
BFDPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BFDPrefs.plist$(ECHO_END)
