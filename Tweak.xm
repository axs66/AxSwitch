#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 通过十六进制数字转换为 UIColor
static UIColor *colorFromHexNumber(NSNumber *hexNumber) {
    unsigned int hexValue = [hexNumber unsignedIntValue];
    CGFloat red = ((hexValue >> 16) & 0xFF) / 255.0;
    CGFloat green = ((hexValue >> 8) & 0xFF) / 255.0;
    CGFloat blue = (hexValue & 0xFF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

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

    NSNumber *sunColorNum = prefs[@"suncolor"];
    NSNumber *moonColorNum = prefs[@"mooncolor"];

    if ([sunColorNum isKindOfClass:[NSNumber class]]) {
        self.onTintColor = colorFromHexNumber(sunColorNum);
    }

    if ([moonColorNum isKindOfClass:[NSNumber class]]) {
        self.thumbTintColor = colorFromHexNumber(moonColorNum);
    }
}

%end
