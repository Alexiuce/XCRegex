//
//  XCRexWindow.m
//  XCRegex
//
//  Created by Alexcai on 16/2/2.
//  Copyright © 2016年 zhidier. All rights reserved.
//

#import "XCRexWindow.h"
#import "RegexKitLite.h"

#define XColor(r,g,b)  [NSColor colorWithRed:(r / 255.0) green:(g/255.0) blue:(b/255.0) alpha:1];

@interface XCRexWindow ()<NSTextViewDelegate>


@property (weak) IBOutlet NSScrollView *patternTextView;
@property (weak) IBOutlet NSScrollView *sourceTextView;
@property (weak) IBOutlet NSScrollView *resultTextView;
@property (weak) IBOutlet NSTextField *resultField;


@property (nonatomic, copy) NSString *patternString;
@property (nonatomic, copy) NSString *sourceString;

@property (nonatomic, copy) NSString *resultString;

@property (nonatomic, strong) NSArray *resultArray;


@end


@implementation XCRexWindow

- (void)awakeFromNib{
    {
        NSTextView *rTextView = _resultTextView.documentView;
        rTextView.font = [NSFont systemFontOfSize:15];
        rTextView.editable = NO;
        rTextView.textColor = XColor(0, 128, 255)
    }
    {
        NSTextView *pTextView = self.patternTextView.documentView;
        pTextView.font = [NSFont systemFontOfSize:15];
        pTextView.delegate = self;
        pTextView.textColor = XColor(255, 128, 0)
    }
    {
        NSTextView *sTextView = self.sourceTextView.documentView;
        sTextView.font = [NSFont systemFontOfSize:15];
        sTextView.delegate = self;
    }
}

- (void)textDidChange:(NSNotification *)notification{
    NSTextView *currentTextView = notification.object;
    if (currentTextView == self.patternTextView.documentView) {
        _patternString = currentTextView.string;
    }else if (currentTextView == self.sourceTextView.documentView){
        _sourceString = currentTextView.string;
    }
    
    if (_patternString && _sourceString) {
        self.resultArray = [_sourceString componentsMatchedByRegex:_patternString];
    }
}

- (void)setResultArray:(NSArray *)resultArray{
    _resultArray = resultArray;
    NSUInteger count = resultArray.count;
    _resultString = @"";
    if (count == 0){
        NSTextView *resultTextView = _resultTextView.documentView;
        resultTextView.string = _resultString;
         self.resultField.stringValue = @"match result : 0 ";
        return;
    }
    for (int i = 0; i < count; i ++) {
        NSString *rString = resultArray[i];
       _resultString = [_resultString stringByAppendingString:rString];
        if (i == count - 1) {break;}

      _resultString =  [_resultString stringByAppendingString:@"    "];
    }
    NSTextView *resultTextView = _resultTextView.documentView;
    resultTextView.string = _resultString;
    self.resultField.stringValue =  [NSString stringWithFormat:@"match result : %zd ",count];
}
/** 关闭窗口 */
- (void)close{
    [super close];
    [[NSApplication sharedApplication] terminate:nil];
}


@end
