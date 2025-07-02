#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import <dispatch/dispatch.h>

// 方法1: 写入激活配置文件
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

    NSLog(@"[SimpleSwitch Crack] 已写入配置文件: %@", prefsPath);
}

// 方法2: 内存补丁地址输出（实际环境下仅用于调试）
void patchBinaryCode() {
    void *handle = dlopen("SimpleSwitch.dylib", RTLD_NOW);
    if (!handle) {
        NSLog(@"[Crack] 无法加载 SimpleSwitch.dylib");
        return;
    }

    uintptr_t baseAddr = (uintptr_t)handle;

    // 预计算地址
    uintptr_t addr1 = baseAddr + 0x4578; // tweakenable 检查
    uintptr_t addr2 = baseAddr + 0x4F90; // dns_bypass 检查

    // ARM64 指令：NOP 与 BRANCH（理论补丁）
    uint32_t nop = 0xD503201F;
    uint32_t b = 0x14000008;

    // 输出以调试
    NSLog(@"[Crack] 基址: 0x%lx", baseAddr);
    NSLog(@"[Crack] 补丁地址1: 0x%lx (写入 NOP: 0x%X)", addr1, nop);
    NSLog(@"[Crack] 补丁地址2: 0x%lx (写入 BRANCH: 0x%X)", addr2, b);

    // 无根越狱环境中不能实际写入，仅用于演示
    // 可注释打开尝试写入（需 root）
    // memcpy((void *)addr1, &nop, sizeof(nop));
    // memcpy((void *)addr2, &b, sizeof(b));
}

// 初始化函数，自动调用破解逻辑
__attribute__((constructor))
static void initialize() {
    NSLog(@"[Apibug Crack] 初始化破解模块");

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        createActivatedPreferences();
        patchBinaryCode();
        NSLog(@"[Apibug Crack] 破解完成");
    });
}
