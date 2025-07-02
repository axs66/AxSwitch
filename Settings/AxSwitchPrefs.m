#import "AxSwitchPrefs.h"
#import <Preferences/PSSpecifier.h>

@implementation AxSwitchPrefs

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    NSString *path = @"/var/mobile/Library/Preferences/com.axs.AxSwitch.plist";
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:path] ?: [NSMutableDictionary dictionary];
    settings[specifier.properties[@"key"]] = value;
    [settings writeToFile:path atomically:YES];

    // 通知热重载
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.axs.AxSwitch/settingschanged"), NULL, NULL, YES);
}

- (id)readPreferenceValue:(PSSpecifier *)specifier {
    NSString *path = @"/var/mobile/Library/Preferences/com.axs.AxSwitch.plist";
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:path];
    return settings[specifier.properties[@"key"]] ?: specifier.properties[@"default"];
}

@end
