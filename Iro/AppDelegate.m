//
//  AppDelegate.m
//  Iro
//
//  Created by Mike Kruk on 2/10/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import "AppDelegate.h"
#import "BFColorPickerPopover.h"
#import "NSColor+Hex.h"

@implementation AppDelegate

@synthesize statusItem;
@synthesize statusItemView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // init status bar
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
    
    [statusItemView setAction:@selector(statusItemClicked)];
    [statusItemView setImage:[NSImage imageNamed:@"Status"]];
    [statusItemView setAlternateImage:[NSImage imageNamed:@"StatusHighlighted"]];

    // cog menu
    settings = [[NSMenu alloc] initWithTitle:@""];
    [settings setAutoenablesItems:NO];
    // add image'd item for PopUpButton
    NSMenuItem *selectedItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
    [selectedItem setImage:[NSImage imageNamed:NSImageNameActionTemplate]];
    [settings addItem:selectedItem];
    
    settingHexValue = [[NSMenuItem alloc] initWithTitle:@"Copy color" action:@selector(copyHexColor) keyEquivalent:@""];
    [settings addItem:settingHexValue];
    // TODO: Option to start app at login
    //[settings addItemWithTitle:@"Start at login" action:@selector(toggleStartAtLogin:) keyEquivalent:@""];
    
    [settings addItemWithTitle:@"Quit" action:@selector(quit) keyEquivalent:@"q"];
    
    menuButton = [[NSPopUpButton alloc] initWithFrame:CGRectMake(200, 358, 50, 50) pullsDown:YES];
    [menuButton setPreferredEdge:NSMaxYEdge];
    [menuButton setMenu:settings];
    
    // callback for picking a color
    [[BFColorPickerPopover sharedPopover] setAction:@selector(didPickColor)];
    // set copy hex menu item
    [self didPickColor];
}

- (void)statusItemClicked
{
    [[BFColorPickerPopover sharedPopover] showRelativeToRect:statusItem.view.frame ofView:statusItem.view preferredEdge:NSMinYEdge];
	[[BFColorPickerPopover sharedPopover] setTarget:self];
    
    // add settings button to color picker viewController
    [[[[BFColorPickerPopover sharedPopover] contentViewController] view] addSubview:menuButton];
}

- (void)didPickColor
{
    NSString *hex = [[[BFColorPickerPopover sharedPopover] color] hexValue];
    if (!hex) {
        [settingHexValue setEnabled:NO];
        return;
    }
    [settingHexValue setEnabled:YES];
    [settingHexValue setTitle:[NSString stringWithFormat:@"Copy \"%@\"", hex]];
}

- (void)copyHexColor
{
    NSString *hex = [[[BFColorPickerPopover sharedPopover] color] hexValue];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:hex  forType:NSStringPboardType];
}

- (void)quit
{
    [NSApp terminate:self];
}
    
- (void)toggleStartAtLogin:(id)sender
{
    NSMenuItem *item = sender;
    item.state = item.state == NSOnState ? NSOffState : NSOnState;
    
    if (item.state == NSOnState) {
        // enable start at login
    } else {
        // disable start at login
    }
}

@end
