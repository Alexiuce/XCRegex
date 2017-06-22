//
//  XCPreferenceController.m
//  XCRegex
//
//  Created by alexiuce  on 2017/6/22.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import "XCPreferenceController.h"
#import "XCCommentKey.h"


@interface XCPreferenceController ()

@property (weak) IBOutlet NSButton *starButton;
@property (weak) IBOutlet NSButton *quitButton;

@end

@implementation XCPreferenceController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self.window setTitlebarAppearsTransparent:YES];
    self.window.styleMask = self.window.styleMask | NSWindowStyleMaskFullSizeContentView;
    [self.window standardWindowButton:NSWindowMiniaturizeButton].hidden = YES;
    [self.window standardWindowButton:NSWindowZoomButton].hidden = YES;
    
    NSLog(@"start %@",[XCDefault boolForKey:XCStartAppKey]? @"yes":@"no");
    self.starButton.state =  [XCDefault boolForKey:XCStartAppKey]? NSOnState : NSOffState;
     NSLog(@"queit %@",[XCDefault boolForKey:XCQuitAppKey]? @"yes":@"no");
    self.quitButton.state = [XCDefault boolForKey:XCQuitAppKey]? NSOnState : NSOffState;
}

- (IBAction)clickStartButton:(NSButton *)sender {
    BOOL isStart = sender.state == NSOnState;
    [XCDefault setBool:isStart forKey:XCStartAppKey];
    [XCDefault synchronize];
    
    [self daemon:isStart];
    
}

- (IBAction)clickQuitButton:(NSButton *)sender {
    BOOL isStart = sender.state == NSOnState;
    [XCDefault setBool:isStart forKey:XCQuitAppKey];
    [XCDefault synchronize];
}



-(void)daemon:(Boolean)install{
    static NSString * const appHelperID = @"com.joinf.www.XCRegexHelper";
    NSString *helperPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Contents/Library/LoginItems/XCRegexHelper.app"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:helperPath]){
        return;
    }

    // Setting login
    // com.xxx.xxx为Helper的BundleID,ture/false设置开启还是关闭
    SMLoginItemSetEnabled(appHelperID, install);    // 设置开启还是关闭
   
    
    NSString *mainAPP = [NSBundle mainBundle].bundleIdentifier?:@"cjz.zhidier.XCRegex";
    BOOL alreadRunning = NO;
    NSArray *runnings = [NSWorkspace sharedWorkspace].runningApplications;
    for (NSRunningApplication *app in runnings) {
        if ([app.bundleIdentifier isEqualToString:mainAPP]) {
            alreadRunning = YES;
            break;
        }
    }
    
    if (alreadRunning) {
        [[NSDistributedNotificationCenter defaultCenter]postNotificationName:@"killme" object:[NSBundle mainBundle].bundleIdentifier];
    }
}



@end
