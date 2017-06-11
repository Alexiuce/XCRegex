//
//  NSString+XCEmpty.m
//  XCRegex
//
//  Created by Alexcai on 2017/6/11.
//  Copyright © 2017年 zhidier. All rights reserved.
//

#import "NSString+XCEmpty.h"

@implementation NSString (XCEmpty)

- (BOOL)xc_isEmpty{
    
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return  temp == nil || temp.length == 0 ;
}

@end
