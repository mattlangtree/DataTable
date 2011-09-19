//
//  DataTableAppDelegate.h
//  DataTable
//
//  Created by Matt Langtree on 19/09/11.
//  Copyright 2011 North of Three. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTViewController;

@interface DataTableAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) NTViewController *viewController;

@end
