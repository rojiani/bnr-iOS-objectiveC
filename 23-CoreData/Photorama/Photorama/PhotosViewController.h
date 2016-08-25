//
//  ViewController.h
//  Photorama
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoStore;


@interface PhotosViewController : UIViewController <UICollectionViewDelegate>
@property (nonatomic) PhotoStore *photoStore;
@end

