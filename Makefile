export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0
export THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AxSwitch

AxSwitch_FILES = Tweak.xm Settings/AxSwitchPrefs.m
AxSwitch_FRAMEWORKS = UIKit Foundation
AxSwitch_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries
AxSwitch_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
