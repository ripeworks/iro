//
//  StatusItemView.h
//  Iro
//
//  Created by Mike Kruk on 2/10/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusItemView : NSView
{
    NSStatusItem *statusItem;
    NSImage *image;
    NSImage *alternateImage;
    bool isHighlighted;
    id popoverActiveMonitor;
}

@property SEL action;
@property id target;

- (id)initWithStatusItem:(NSStatusItem *)item;
- (void)setHighlighted:(BOOL)highlighted;
- (void)setImage:(NSImage *)newImage;
- (void)setAlternateImage:(NSImage *)newImage;
    
@end
