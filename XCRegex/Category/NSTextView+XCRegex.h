//
//  NSTextView+XCRegex.h
//  XCRegex
//
//  Created by Alexcai on 2017/6/11.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextView (XCRegex)

- (void)xc_regextHightLightWithPattern:(NSString *)pattern;

@end
