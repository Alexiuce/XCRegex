//
//  XCRexWindow.m
//  XCRegex
//
//  Created by Alexcai on 16/2/2.
//  Copyright © 2016年 zhidier. All rights reserved.
//

#import "XCRexWindow.h"
#import "NSTextView+XCRegex.h"




@interface XCRexWindow ()<NSTextViewDelegate>



@property (unsafe_unretained) IBOutlet NSTextView *patternTextView;
@property (unsafe_unretained) IBOutlet NSTextView *sourceTextView;
@property (nonatomic ,strong) NSStatusItem *statusItem;

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

}


#pragma mark - 事件监听
- (void)clickStatusItem{
    self.visible ? nil :[self makeKeyAndOrderFront:nil];
}
- (void)textDidChange:(NSNotification *)notification{
    [_patternTextView xc_hightLightForRegex];
    [_sourceTextView xc_regextHightLightWithPattern:_patternTextView.string];
}





@end
