//
//  ViewController.m
//  Photorama
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoStore.h"

@interface PhotosViewController ()
@property (nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // start web service exchange when VC comes on screen
    [self.photoStore fetchInterestingPhotosWithCompletion:^(NSArray *photos) {
        NSLog(@"Found %lu photos", (unsigned long)photos.count);
        
        if (photos.count == 0) {
            NSLog(@"Zero photos! Sad times.");
            return;
        }
        
        [self.photoStore fetchImageForPhoto:photos.firstObject
                                 completion:^(UIImage *image) {
            // UI Update must be done on the main thread (p. 323)
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.imageView.image = image;
            }];
        }];
    }];
}

@end
