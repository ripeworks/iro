//
//  AppDelegate.h
//  Iro
//
//  Created by Mike Kruk on 2/10/14.
//  Copyright (c) 2014 Ripeworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>
{
    NSPopUpButton *menuButton;
    NSMenu *settings;
    NSMenuItem *settingHexValue;
    id popoverActiveMonitor;
}
    
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end
