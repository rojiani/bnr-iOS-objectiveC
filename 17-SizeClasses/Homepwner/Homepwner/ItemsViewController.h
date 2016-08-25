//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemStore;
@class ImageStore;

/* itemStore & imageStore injected in AppDelegate's 
   application:didFinishLaunchingWithOptions:
   method. */

@interface ItemsViewController : UITableViewController

@property (nonatomic) ItemStore  *itemStore;
@property (nonatomic) ImageStore *imageStore;

@end
