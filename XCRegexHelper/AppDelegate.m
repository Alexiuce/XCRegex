//
//  AppDelegate.m
//  XCRegexHelper
//
//  Created by alexiuce  on 2017/6/22.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
     [self runMainApp:@"cjz.zhidier.XCRegex" appName:@"XCRegex"];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
/** 运行开机自启动的app
 
 @param identifier 主app的标识符
 @param appName 主app的名称（在MacOS文件夹下的名称）
 */
- (void) runMainApp:(NSString*)identifier appName:(NSString*)appName{
    // Check if main app is already running; if yes, do nothing and terminate helper app
    BOOL alreadyRunning = NO;
    NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in running){
        if ([[app bundleIdentifier] isEqualToString:identifier]){
            alreadyRunning = YES;
        }
    }
    if (!alreadyRunning){
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(quitApp) name:@"killme" object:identifier];
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSArray *p = [path pathComponents];
        NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:p];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents addObject:@"MacOS"];
        [pathComponents addObject:appName];
        NSString *newPath = [NSString pathWithComponents:pathComponents];
        [[NSWorkspace sharedWorkspace] launchApplication:newPath];
    }else{
        [self quitApp];
    }
   
}
- (void)quitApp{
     [NSApp terminate:nil];
}


@end
