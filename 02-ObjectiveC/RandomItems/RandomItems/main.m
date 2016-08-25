//
//  main.m
//  RandomItems
//
//  Created by Rojiani, Navid on 4/18/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        Item *backpack = [[Item alloc] initWithName:@"Backpack"];
        [items addObject:backpack];
        
        Item *calculator = [[Item alloc] initWithName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        backpack = nil;
        calculator = nil;
        
        for (Item *item in items) {
            NSLog(@"%@", item);
        }
        
        // Destroy the mutable array object
        NSLog(@"Setting items to nil..."); // this will call dealloc
        items = nil;
    }
    return 0;
}
