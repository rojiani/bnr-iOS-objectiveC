//
//  ImageStore.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStore.h"

@interface ImageStore ()
@property (nonatomic) NSCache *cache;
@end

@implementation ImageStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [NSCache new];
    }
    return self;
}

// MARK: - Image Management

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.cache setObject:image forKey:key];
    
    // Create a local URL where the image will be saved
    NSURL *imageURL = [self imageURLForKey:key];
    
    // Turn the image into compressed JPEG data & save it
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [imageData writeToURL:imageURL atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key {
    UIImage *image = [self.cache objectForKey:key];
    
    if (image == nil) { // not already in the cache - load from disk
        NSURL *imageURL = [self imageURLForKey:key];
        NSError *error = nil;   // p. 252
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL
                                                  options:0
                                                    error:&error];
        if (imageData == nil) {
            NSLog(@"Failed to load image %@. Error: %@", key, error);
        } else {
            NSLog(@"Loaded image %@ from disk.", key);
            image = [UIImage imageWithData:imageData];
            [self.cache setObject:image forKey:key];
        }
    }
    
    return image;
}

- (void)deleteImageForKey:(NSString *)key {
    [self.cache removeObjectForKey:key];    // delete from cache
    
    // delete from filesystem
    NSURL *imageURL = [self imageURLForKey:key];
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] removeItemAtURL:imageURL
                                                             error:&error]; // p. 251-252 "out parameter"
    if (success) {
        NSLog(@"Deleted the image at %@", imageURL);
    } else {
        NSLog(@"Failed to delete image at %@ because: %@", imageURL, error);
    }
    
}

// Get URL for image file on disk
- (NSURL *)imageURLForKey:(NSString *)key {
    NSArray *directories =
        [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                               inDomains:NSUserDomainMask];
    
    NSURL *documentDirectory = directories.firstObject;
    return [documentDirectory URLByAppendingPathComponent:key];
}

@end
