//
//  Item.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "Item.h"

@implementation Item

// MARK: - Initializers

- (instancetype)initWithName:(NSString *)name
                serialNumber:(NSString *)serialNumber
              valueInDollars:(int)valueInDollars {
    self = [super init];
    if (self) {
        _name = [name copy];
        _serialNumber = [serialNumber copy];
        _valueInDollars = valueInDollars;
        _dateCreated = [NSDate date];
        _itemKey = [NSUUID UUID].UUIDString;
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:@"New Item" serialNumber:@"" valueInDollars:0];
}

- (instancetype)initWithRandomValues {
    NSArray *adjectives = @[ @"Fluffy", @"Rusty", @"Shiny" ];
    NSArray *nouns = @[ @"Bear", @"Spork", @"Mac" ];
    
    NSString *adjective = adjectives[arc4random_uniform((int)adjectives.count)];
    NSString *noun = nouns[arc4random_uniform((int)nouns.count)];
    NSString *name = [NSString stringWithFormat:@"%@ %@", adjective, noun];
    
    NSString *serial = [[[NSUUID UUID] UUIDString] substringToIndex:8];
    
    int value = (int)arc4random_uniform(100);
    
    return [self initWithName:name
                 serialNumber:serial
               valueInDollars:value];
}

// MARK: - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}


@end

