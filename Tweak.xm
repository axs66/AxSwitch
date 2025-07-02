#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.axs.AxSwitch.plist"];
    return [[prefs objectForKey:@"enabled"] boolValue];
}

%hook UISwitch

- (void)didMoveToWindow {
    %orig;

    if (!isEnabled()) return;

    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.axs.AxSwitch.plist"];
    if (!prefs) return;

    NSNumber *sun = prefs[@"suncolor"];
    NSNumber *moon = prefs[@"mooncolor"];

    if ([sun isKindOfClass:[NSNumber class]]) {
        self.onTintColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.2 alpha:1.0]; // 示例颜色
    }

    if ([moon isKindOfClass:[NSNumber class]]) {
        self.thumbTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.5 alpha:1.0]; // 示例颜色
    }
}

%end
