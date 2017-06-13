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



- (void)xc_hightLightForRegex{
    if ([self.string xc_isEmpty]) {return;}
    NSRange selectRange = self.selectedRange;   // 记录当前光标位置
    NSRange range = NSMakeRange(0, self.string.length);
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:self.string];
    [attributeText setAttributes:@{NSFontAttributeName : self.font,NSForegroundColorAttributeName:[NSColor whiteColor]} range:range];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(|\\)|\\||\\+|\\.|\\*|\\?|\\$|\\^" options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regex enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [attributeText addAttributes:@{NSForegroundColorAttributeName:XColor(255, 128, 0)} range:result.range];
    }];
    
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"\\[.*?\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regex1 enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [attributeText addAttributes:@{NSForegroundColorAttributeName:XColor(50, 108, 191)} range:result.range];
    }];
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:NSRegularExpressionIgnoreMetacharacters error:nil];
    
    [regex2 enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [attributeText addAttributes:@{NSForegroundColorAttributeName:XColor(255, 128, 0)} range:result.range];
    }];
    NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"\\w" options:NSRegularExpressionIgnoreMetacharacters error:nil];
    
    [regex3 enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [attributeText addAttributes:@{NSForegroundColorAttributeName:XColor(255, 128, 0)} range:result.range];
    }];
    
    [self.textStorage setAttributedString:attributeText];
    
    self.selectedRange = selectRange;
}


- (void)xc_regextHightLightWithPattern:(NSString *)pattern{
    if ([self.string xc_isEmpty]) {return;}
    
    NSRange selectRange = self.selectedRange;
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:self.string];
    NSRange range = NSMakeRange(0, self.string.length);
    [attributeText setAttributes:@{NSFontAttributeName : [NSFont systemFontOfSize:15],NSForegroundColorAttributeName: self.textColor} range:range];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    __block int index = 0;
    [regex enumerateMatchesInString:self.string options:0 range:NSMakeRange(0, self.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSColor *backColor = index % 2 == 0 ? [NSColor redColor]: XColor(50, 108, 191);
        
        [attributeText addAttributes:@{NSBackgroundColorAttributeName:backColor,NSFontAttributeName : [NSFont boldSystemFontOfSize:23]} range:result.range];
        index++;
    }];
    [self.textStorage setAttributedString:attributeText];
    self.selectedRange = selectRange;
}




@end
