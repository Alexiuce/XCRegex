//
//  XCRexWindow.m
//  XCRegex
//
//  Created by Alexcai on 16/2/2.
//  Copyright © 2016年 zhidier. All rights reserved.
//

#import "XCRexWindow.h"
#import "NSTextView+XCRegex.h"
#import "XCAccessController.h"




@interface XCRexWindow ()<NSTextViewDelegate>



@property (unsafe_unretained) IBOutlet NSTextView *patternTextView;
@property (unsafe_unretained) IBOutlet NSTextView *sourceTextView;
@property (nonatomic ,strong) NSStatusItem *statusItem;

@property (nonatomic, strong)XCAccessController *accessController;

@end


@implementation XCRexWindow

- (void)awakeFromNib{
    // 设置UI
    _patternTextView.font = [NSFont systemFontOfSize:15];
    _patternTextView.delegate = self;
    _patternTextView.textColor = [NSColor whiteColor];
    _patternTextView.automaticQuoteSubstitutionEnabled = NO;
    
    _sourceTextView.font = [NSFont systemFontOfSize:15];
    _sourceTextView.delegate = self;
    _sourceTextView.textColor = [NSColor whiteColor];
    _sourceTextView.automaticQuoteSubstitutionEnabled = NO;
    // 设置状态栏icon
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"statusItem"];
    self.statusItem.target = self;
    self.statusItem.action = @selector(clickStatusItem);
    
    // 设置window titleBar 透明
    self.titlebarAppearsTransparent = YES;
    // 设置内容填充整个window
    self.styleMask = self.styleMask | NSFullSizeContentViewWindowMask;
    // 隐藏全屏按钮
    [self standardWindowButton:NSWindowZoomButton].hidden = YES;
    [self textDidChange:[NSNotification notificationWithName:@"begin" object:nil]];
    
    
    NSButton *btn = [NSButton buttonWithImage:[NSImage imageNamed:@"statusItem"] target:self action:@selector(clickButton:)];
    btn.bezelStyle = NSBezelStyleRegularSquare;
    btn.bordered = NO;
    NSView *themeView = [[self contentView] superview];
    NSRect rect = themeView.bounds;
    btn.frame = NSMakeRect(rect.size.width - 30, -4, 30, 25);
    NSArray *subViews = [themeView subviews];
    NSView *containerView = [subViews objectAtIndex:1];
    [containerView addSubview:btn positioned:NSWindowAbove relativeTo:nil];
    
    NSRect oldRect = self.frame;
    CGFloat tx = (oldRect.size.width - 80) * 0.5;
    // 设置 custom window title
    NSRect titleRect = NSMakeRect(tx, -4, 80, 25);
    NSTextField *titleLabl = [[NSTextField alloc]initWithFrame:titleRect];
    titleLabl.alignment = NSTextAlignmentCenter;
    [titleLabl setBezeled:NO];
    [titleLabl setDrawsBackground:NO];
    [titleLabl setSelectable:NO];
    titleLabl.stringValue = @"XCRegex";
    titleLabl.font = [NSFont systemFontOfSize:15];
    titleLabl.textColor = [NSColor blackColor];
    [containerView addSubview:titleLabl positioned:NSWindowAbove relativeTo:nil];
    
    
    NSView *accessView = self.accessController.view;
    accessView.frame = NSMakeRect(oldRect.size.width, 0, accessView.bounds.size.width, accessView.bounds.size.height);
    [self.contentView addSubview:self.accessController.view];

}


#pragma mark - 事件监听
- (void)clickStatusItem{
    self.visible ? nil :[self makeKeyAndOrderFront:nil];
}
- (void)textDidChange:(NSNotification *)notification{
    [_patternTextView xc_hightLightForRegex];
    [_sourceTextView xc_regextHightLightWithPattern:_patternTextView.string];
}

- (void)clickButton:(NSButton *)btn{
    CGFloat deltaWidth = btn.state ? 300 : -300;
    NSRect oldRect = self.frame;
    NSRect newRect = NSMakeRect(oldRect.origin.x, oldRect.origin.y, oldRect.size.width + deltaWidth, oldRect.size.height);
    [self setFrame:newRect display:YES animate:YES];
}


- (XCAccessController *)accessController{
    if (_accessController == nil) {
        _accessController = [[XCAccessController alloc]initWithNibName:@"XCAccessController" bundle:nil];
    }
    return  _accessController;
}

@end
