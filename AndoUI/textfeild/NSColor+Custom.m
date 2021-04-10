//
//  NSColor+Custom.m
//  iKIGAI_Download
//
//  Created by dong on 2020/6/22.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "NSColor+Custom.h"

@implementation NSColor (Custom)


+ (NSColor*)colorWithHex:(int)rgbValue
{
   
    return [NSColor colorWithRed:((int)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0];
}


@end
