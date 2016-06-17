//
//  XCRexWindow.m
//  XCRegex
//
//  Created by Alexcai on 16/2/2.
//  Copyright © 2016年 zhidier. All rights reserved.
//

#import "XCRexWindow.h"
#import "RegexKitLite.h"



@interface XCRexWindow ()<NSTextViewDelegate>


@property (weak) IBOutlet NSScrollView *patternTextView;
@property (weak) IBOutlet NSScrollView *sourceTextView;
@property (weak) IBOutlet NSScrollView *resultTextView;


@property (nonatomic, copy) NSString *patternString;
@property (nonatomic, copy) NSString *sourceString;

@property (nonatomic, copy) NSString *resultString;

@property (nonatomic, strong) NSArray *resultArray;


@end


@implementation XCRexWindow

- (void)awakeFromNib{
    {
        NSTextView *rTextView = _resultTextView.documentView;
        rTextView.font = [NSFont systemFontOfSize:30];
        rTextView.editable = NO;
    }
    {
        NSTextView *pTextView = self.patternTextView.documentView;
        pTextView.font = [NSFont systemFontOfSize:17];
        pTextView.delegate = self;
    }
    {
        NSTextView *sTextView = self.sourceTextView.documentView;
        sTextView.font = [NSFont systemFontOfSize:27];
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
        
        return;
    }
    for (int i = 0; i < count; i ++) {
        NSString *rString = resultArray[i];
       _resultString = [_resultString stringByAppendingString:rString];
      _resultString =  [_resultString stringByAppendingString:@"\n"];
    }
    NSTextView *resultTextView = _resultTextView.documentView;
    resultTextView.string = _resultString;
}




@end
