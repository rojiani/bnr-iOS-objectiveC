//
//  ImageStore.h
//  Homepwner
//
//  Created by Rojiani, Navid on 4/21/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
