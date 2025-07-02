#ifdef THEOS
%hook UISwitch

- (NSNumber *)dns_bypass {
    return @YES;
}

- (void)setDns_bypass:(NSNumber *)bypass {
    if ([bypass boolValue]) {
        %orig(bypass);
    }
    NSLog(@"[Apibug Crack] 阻止设置 dns_bypass 为 false");
}

%end
#endif
