//
//  XCHelperController.m
//  XCRegex
//
//  Created by alexiuce  on 2017/6/2.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import "XCHelperController.h"

@interface XCHelperController ()
@property (weak) IBOutlet NSTextField *versionLabel;

@end

@implementation XCHelperController

- (void)windowDidLoad {
    [super windowDidLoad];
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    self.versionLabel.stringValue = [NSString stringWithFormat:@"version: %@",version];
    self.window.titlebarAppearsTransparent = YES;
    self.window.styleMask = self.window.styleMask | NSWindowStyleMaskFullSizeContentView;
    [self.window standardWindowButton:NSWindowMiniaturizeButton].hidden = YES;
    [self.window standardWindowButton:NSWindowZoomButton].hidden = YES;
   
}

@end
