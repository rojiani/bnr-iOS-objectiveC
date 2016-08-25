//
//  Item.h
//  RandomItems
//
//  Created by Rojiani, Navid on 4/18/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) Item *containedItem;
@property (nonatomic, weak) Item *container;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

+ (instancetype)randomItem;

- (instancetype)initWithName:(NSString *)name
              valueInDollars:(int)value
                serialNumber:(NSString *)sNumber;

- (instancetype)initWithName:(NSString *)name;

@end
