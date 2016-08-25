//
//  Photo.h
//  Photorama
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly      ) NSURL    *remoteURL;
@property (nonatomic, readonly, copy) NSString *photoID;
@property (nonatomic, readonly      ) NSDate   *dateTaken;
@property (nonatomic                ) UIImage  *image;

- (instancetype)initWithTitle:(NSString *)title
                      photoID:(NSString *)photoID
                    remoteURL:(NSURL *)URL
                    dateTaken:(NSDate *)dateTaken NS_DESIGNATED_INITIALIZER;

@end
