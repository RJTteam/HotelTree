//
//  UIColor+Hexadecimal.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "UIColor+Hexadecimal.h"

@implementation UIColor (Hexadecimal)
+ (UIColor *)colorWithHexString:(NSString *)hexString{
    unsigned regValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; //for pass '#' character
    [scanner scanHexInt:&regValue];
    
    return [UIColor colorWithRed:((float)((regValue & 0xFF0000) >> 16))/255.0 green:((float)((regValue & 0xFF00) >> 8))/255.0 blue:((float)(regValue & 0xFF))/255.0 alpha:1.0];
}

@end
