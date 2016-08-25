//
//  PhotoCollectionViewCell.h
//  Photorama
//
//  Created by Rojiani, Navid on 4/22/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic) IBOutlet UIImageView             *imageView;
@property (nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (void)updateWithImage:(UIImage *)image;

@end
