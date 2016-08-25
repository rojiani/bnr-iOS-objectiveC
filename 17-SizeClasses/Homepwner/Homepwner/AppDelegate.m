//
//  AppDelegate.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemStore.h"
#import "ItemsViewController.h"
#import "ImageStore.h"

@interface AppDelegate ()
@property (nonatomic) ItemStore *itemStore;
@end



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Create an ItemStore
    ItemStore *itemStore = [ItemStore new];
    self.itemStore = itemStore;     // AppDelegate has class extension property for archiving.

    // Create an ImageStore
    ImageStore *imageStore = [ImageStore new];
    
    // Access the ItemsViewController
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    ItemsViewController *ivc = (ItemsViewController *)navController.topViewController;
    ivc.itemStore = itemStore;          // Inject the itemStore
    ivc.imageStore = imageStore;        // Inject the imageStore
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store
    // enough application state information to restore your application to its current state in
    // case it is terminated later.
    // If your application supports background execution, this method is called instead of
    // applicationWillTerminate: when the user quits.
    
    BOOL success = [self.itemStore saveChanges];
    if (success) {
        NSLog(@"Saved %lu items to disk.", (unsigned long)self.itemStore.allItems.count);
    } else {
        NSLog(@"Failed to save the items to disk.");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also
    // applicationDidEnterBackground:.
}

@end
