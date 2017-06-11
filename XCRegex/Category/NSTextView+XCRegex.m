//
//  NSTextView+XCRegex.m
//  XCRegex
//
//  Created by Alexcai on 2017/6/11.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import "NSTextView+XCRegex.h"
#import "RegexKitLite.h"
#import "NSString+XCEmpty.h"
#import <AppKit/AppKit.h>


@implementation NSTextView (XCRegex)

- (void)xc_regextHightLightWithPattern:(NSString *)pattern{
    if ([self.string xc_isEmpty]) {return;}
    NSRange selectRange = self.selectedRange;
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:self.string];
    NSRange range = NSMakeRange(0, self.string.length);
    [attributeText setAttributes:@{NSFontAttributeName : self.font,NSForegroundColorAttributeName: self.textColor} range:range];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    [regex enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [attributeText addAttributes:@{NSBackgroundColorAttributeName: [NSColor redColor]} range:result.range];
        
    }];
    [self.textStorage setAttributedString:attributeText];
    self.selectedRange = selectRange;
}

@end
