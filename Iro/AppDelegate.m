//
//  AppDelegate.m
//  Iro
//
//  Created by Mike Kruk on 2/10/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import "AppDelegate.h"
#import "BFColorPickerPopover.h"

@implementation AppDelegate
    
@synthesize statusItem;
@synthesize statusItemView;
    
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // init status bar
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
    
    // set it up!
    //[statusItem setAction:@selector(statusItemClicked)];
    [statusItemView setAction:@selector(statusItemClicked)];
    [statusItemView setImage:[NSImage imageNamed:@"Status"]];
    [statusItemView setAlternateImage:[NSImage imageNamed:@"StatusHighlighted"]];
    //[statusItem setImage:[NSImage imageNamed:@"Status"]];
    //[statusItem setView:statusItemView];
    
    
	//[[BFColorPickerPopover sharedPopover] setAction:@selector(colorChanged:)];
	//[[BFColorPickerPopover sharedPopover] setColor:backgroundView.backgroundColor];
}

- (void)statusItemClicked
{
    [[BFColorPickerPopover sharedPopover] showRelativeToRect:statusItem.view.frame ofView:statusItem.view preferredEdge:NSMinYEdge];
	[[BFColorPickerPopover sharedPopover] setTarget:self];
}

@end
