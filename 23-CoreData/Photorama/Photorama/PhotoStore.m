//
//  PhotoStore.m
//  Photorama
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "PhotoStore.h"
#import "Photo.h"
#import "FlickrAPI.h"

@interface PhotoStore ()
@property (nonatomic) NSURLSession *session;
@end

@implementation PhotoStore

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config =
            [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)fetchInterestingPhotosWithCompletion:(void(^)(NSArray *))completion {
    NSParameterAssert(completion);  // App will exit if no completion handler passed.
    NSURL *url                 = [FlickrAPI interestingPhotosURL];
    NSURLRequest *request      = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *error) {
        NSArray *photos = [self processInterestingPhotosRequestWithData:data
                                                                  error:error];
        // Invoke the completion handler argument that was passed as argument in
        // call to this method, from PhotosViewController's viewDidLoad method.
        // This will add the photos to PhotoDataSource and load the image views into
        // the collection view.
        completion(photos);
    }];
    [task resume];
}


/**
 * Converts the JSON response data from the Flickr API request into an array 
 * of Photo objects.
 * Calls FlickrAPI's photosFromJSONData: method to parse the JSON data and 
 * create Photo model objects.
 * @param data JSON response data
 * @return Array of Photo
 */
- (NSArray *)processInterestingPhotosRequestWithData:(NSData *)data
                                               error:(NSError *)error {
    
    if (data != nil) {
        return [FlickrAPI photosFromJSONData:data];
    } else {
        return nil;
    }
}

- (void)fetchImageForPhoto:(Photo *)photo
                completion:(void(^)(UIImage *))completion {
    
    NSParameterAssert(photo);
    NSParameterAssert(completion);

    // If already downloaded...
    if (photo.image != nil) {
        completion(photo.image);
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:photo.remoteURL];
    NSURLSessionDataTask *task =
        [self.session dataTaskWithRequest:request
                        completionHandler:^(NSData *data,
                                            NSURLResponse *response,
                                            NSError *error) {
                            UIImage *image = [self processImageRequestWithData:data
                                                                         error:error];
                            if (image != nil) {
                                photo.image = image;
                            }
                            completion(image);
        }];

    [task resume];
}


/** Processes downloaded data from Photo's URL into an image */
- (UIImage *)processImageRequestWithData:(NSData *)data
                                   error:(NSError *)error {
    if (data != nil) {
        UIImage *image = [UIImage imageWithData:data];
        return image;
    } else {
        return nil;
    }
}

@end
