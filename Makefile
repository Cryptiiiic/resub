ARCHS = armv7 arm64
DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = resub
resub_FILES = main.m AppDelegate.m RootViewController.m
resub_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall -9 resub"

clean_::
	@rm -Rf .theos
	@rm -Rf packages/*
	@rm -Rf obj

after-stage::
	$(FAKEROOT) mv $(THEOS_STAGING_DIR)/Applications/resub.app/resub $(THEOS_STAGING_DIR)/Applications/resub.app/resub-app
	$(FAKEROOT) mv $(THEOS_STAGING_DIR)/Applications/resub.app/re $(THEOS_STAGING_DIR)/Applications/resub.app/resub
	$(FAKEROOT) chmod 6755 $(THEOS_STAGING_DIR)/Applications/resub.app/resub-app
	$(FAKEROOT) chown 0:0 $(THEOS_STAGING_DIR)/Applications/resub.app/resub-app
	$(FAKEROOT) chmod 6755 $(THEOS_STAGING_DIR)/Applications/resub.app/resub
	$(FAKEROOT) chown 0:0 $(THEOS_STAGING_DIR)/Applications/resub.app/resub
	$(FAKEROOT) ldid -S./entitlements.xml $(THEOS_STAGING_DIR)/Applications/resub.app/resub-app
