//
//  AppDelegate.m
//  XCRegex
//
//  Created by Alexcai on 16/2/2.
//  Copyright © 2016年 zhidier. All rights reserved.
//

#import "AppDelegate.h"
#import "XCHelperController.h"
#import "XCPreferenceController.h"


@interface AppDelegate ()
@property (nonatomic, strong) XCHelperController *helperController;
@property (nonatomic, strong) XCPreferenceController *preference;


@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    if (flag == NO) {
        [self.window makeKeyAndOrderFront:nil];
    }
    return YES;
}
- (IBAction)clickHelp:(id)sender {
    if (_helperController == nil) {
        _helperController = [[XCHelperController alloc]initWithWindowNibName:@"XCHelperController"];
    }
    [_helperController showWindow:nil];
}
- (IBAction)clickPreference:(NSMenuItem *)sender {

    if (_preference == nil) {
        _preference = [[XCPreferenceController alloc]initWithWindowNibName:@"XCPreferenceController"];
    }
    [_preference showWindow:self];
    
    
}



@end
