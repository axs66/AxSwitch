ARCHS = arm64
TARGET = iphone:clang:latest:16.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SimpleSwitchCrack

SimpleSwitchCrack_FILES = Tweak.xm SimpleSwitch_Crack.mm
SimpleSwitchCrack_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
