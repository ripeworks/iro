//
//  StatusItemView.m
//  Iro
//
//  Created by Mike Kruk on 2/10/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import "StatusItemView.h"
#import "BFColorPickerPopover.h"

@implementation StatusItemView
    
- (id)initWithStatusItem:(NSStatusItem *)item
{
    CGFloat thickness = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, thickness, thickness);
    self = [super initWithFrame:itemRect];
    
    popoverActiveMonitor = nil;

    if (self != nil) {
        statusItem = item;
        statusItem.view = self;
    }
    return self;
}

- (void)mouseDown:(NSEvent *)event
{
    // perform action and highlight status item
    [NSApp sendAction:self.action to:self.target from:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self setHighlighted:YES];
    
    // watch for clicks outside of view
    if(popoverActiveMonitor == nil)
    {
        popoverActiveMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseUp|NSRightMouseDownMask handler:^(NSEvent* event)
        {
            [self dismissPopover:event];
        }];
    }
}

- (void)dismissPopover:(NSEvent *)event
{
    // remove click monitor
    if(popoverActiveMonitor)
    {
        [NSEvent removeMonitor:popoverActiveMonitor];
        popoverActiveMonitor = nil;
    }

    // close popover
    [self setHighlighted:NO];
    [[BFColorPickerPopover sharedPopover] close];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:isHighlighted];
        
    NSImage *icon = isHighlighted ? alternateImage : image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
        
    [icon drawAtPoint:iconPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (isHighlighted == highlighted) return;
    isHighlighted = highlighted;
    [self setNeedsDisplay:YES];
}

- (void)setImage:(NSImage *)newImage
{
    if (image != newImage) {
        image = newImage;
        [self setNeedsDisplay:YES];
    }
}
    
- (void)setAlternateImage:(NSImage *)newImage
{
    if (alternateImage != newImage) {
        alternateImage = newImage;
        if (isHighlighted) {
            [self setNeedsDisplay:YES];
        }
    }
}

@end
