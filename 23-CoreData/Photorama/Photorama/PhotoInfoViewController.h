//
//  PhotoInfoViewController.h
//  Photorama
//
//  Created by Rojiani, Navid on 4/22/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;
@class PhotoStore;

@interface PhotoInfoViewController : UIViewController
@property (nonatomic) Photo      *photo;
@property (nonatomic) PhotoStore *photoStore;
@end
