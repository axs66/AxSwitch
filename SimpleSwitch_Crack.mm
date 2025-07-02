#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>

void createActivatedPreferences() {
    NSString *prefsPath = @"/var/mobile/Library/Preferences/com.sini921.simpleswitchprefs.plist";
    NSDictionary *activatedPrefs = @{
        @"enabled": @YES,
        @"tweakenable": @YES,
        @"suncolor": @YES,
        @"mooncolor": @YES,
        @"starcolor": @YES,
        @"cloudcolor": @YES,
        @"enablebgcolor": @YES,
        @"closebgcolor": @YES
    };
    [activatedPrefs writeToFile:prefsPath atomically:YES];
    NSLog(@"[SimpleSwitch Crack] 激活配置文件已写入: %@", prefsPath);
}

void patchBinaryCode() {
    void *handle = dlopen("SimpleSwitch.dylib", RTLD_NOW);
    if (!handle) {
        NSLog(@"[Crack] 无法加载 SimpleSwitch.dylib");
        return;
    }

    uintptr_t baseAddr = (uintptr_t)handle;

    // 补丁位置与指令
    uintptr_t addr1 = baseAddr + 0x4578;
    uintptr_t addr2 = baseAddr + 0x4F90;
    uint32_t nop = 0xD503201F;
    uint32_t b = 0x14000008;

    // 示例：写入指令（需 root 权限且无沙盒，通常无根系统无法使用）
    NSLog(@"[Crack] 补丁地址1: 0x%lx -> NOP", addr1);
    NSLog(@"[Crack] 补丁地址2: 0x%lx -> BRANCH", addr2);
}

__attribute__((constructor))
static void initialize() {
    NSLog(@"[Apibug Crack] 初始化模块...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        createActivatedPreferences();
        patchBinaryCode();
    });
}
