//
//  PhotoInfoViewController.m
//  Photorama
//
//  Created by Rojiani, Navid on 4/22/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "PhotoInfoViewController.h"
#import "Photo.h"
#import "PhotoStore.h"

@interface PhotoInfoViewController ()
@property (nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.photoStore fetchImageForPhoto:self.photo
                             completion:^(UIImage *image) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     self.imageView.image = image;
                                 }];
                             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    self.navigationItem.title = self.photo.title;
}

@end
