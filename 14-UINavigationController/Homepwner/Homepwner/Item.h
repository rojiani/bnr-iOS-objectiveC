//
//  Item.h
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *serialNumber;
@property (nonatomic      ) int      valueInDollars;
@property (nonatomic      ) NSDate   *dateCreated;

- (instancetype)initWithName:(NSString *)name
                serialNumber:(NSString *)serialNumber
              valueInDollars:(int)valueInDollars NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithRandomValues;

@end
