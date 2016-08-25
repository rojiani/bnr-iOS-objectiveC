//
//  DetailViewController.h
//  Homepwner
//
//  Created by Rojiani, Navid on 4/20/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ImageStore;

/* item & imageStore injected in ItemViewController's
   prepareForSegue:sender: method. */

@interface DetailViewController : UIViewController

@property (nonatomic) Item       *item;
@property (nonatomic) ImageStore *imageStore;

@end

