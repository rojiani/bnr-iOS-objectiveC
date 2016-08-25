//
//  Item.m
//  RandomItems
//
//  Created by Rojiani, Navid on 4/18/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (instancetype)randomItem {
    // Create an immutable array of 3 adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    // ... of 3 nouns
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    // Get the idx of a random adj/noun from the lists
    unsigned int adjectiveIndex =
        arc4random_uniform((unsigned int)[randomAdjectiveList count]);
    unsigned int nounIndex =
    arc4random_uniform((unsigned int)[randomNounList count]);
    
    // Note that NSInteger is not an object, but a typedef for "long"
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    // Generate the random value in dollars, 0-99
    int randomValue = arc4random_uniform(100);
    
    // Use NSUUID to generate a random 5-letter string for the serial number
    NSString *randomSerialNumber = [[[NSUUID UUID] UUIDString] substringFromIndex:5];
    
    // Instantiate the new item with the random values
    // Note use of 'self'
    Item *newItem = [[self alloc] initWithName:randomName
                                valueInDollars:randomValue
                                  serialNumber:randomSerialNumber];
    return newItem;
}

- (instancetype)initWithName:(NSString *)name
              valueInDollars:(int)value
                serialNumber:(NSString *)sNumber {
    // Call the superclass' designated initializer
    self = [super init];
    
    if (self) {
        _name = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    return [self initWithName:name
               valueInDollars:0
                 serialNumber:@""];
}

// Override init to call initWithName
- (instancetype) init {
    return [self initWithName:@"Item"];
}

- (void)dealloc {
    NSLog(@"Destroyed: %@", self);
}

- (void)setContainedItem:(Item *)containedItem {
    _containedItem = containedItem;
    self.containedItem.container = self;
}

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
            self.name,
            self.serialNumber,
            self.valueInDollars,
            self.dateCreated];
    return descriptionString;
}

@end
