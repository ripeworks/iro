//
//  NSColor+Hex.m
//  Iro
//
//  Created by Mike Kruk on 2/11/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import "NSColor+Hex.h"

@implementation NSColor (Hex)

- (NSString *)hexValue
{
    NSColor *rgbColor = [self colorUsingColorSpaceName:NSDeviceRGBColorSpace];
    if (!rgbColor) return nil;
    
    NSString* hex = [NSString stringWithFormat:@"%02x%02x%02x",
                     (int) (rgbColor.redComponent * 0xFF), (int) (rgbColor.greenComponent * 0xFF),
                     (int) (rgbColor.blueComponent * 0xFF)];
    return hex;
}
    
@end
