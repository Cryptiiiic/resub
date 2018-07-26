ARCHS = armv7 arm64
export TARGET = iphone:clang:11.1:7.0
DEBUG = 0
FINAL_PACKAGE = 1
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = resub
$(APPLICATION_NAME)_FILES = main.m AppDelegate.m RootViewController.m
$(APPLICATION_NAME)_FRAMEWORKS = UIKit CoreGraphics
$(APPLICATION_NAME)_CODESIGN_FLAGS = -Sent.xml
include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall -9 resub"

clean_::
	@rm -Rf .theos
	@rm -Rf packages
	@rm -Rf obj

after-stage::
	$(FAKEROOT) chown 0:0 $(THEOS_STAGING_DIR)/Applications/resub.app/resub
	$(FAKEROOT) chmod 6755 $(THEOS_STAGING_DIR)/Applications/resub.app/resub
