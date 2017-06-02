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
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
