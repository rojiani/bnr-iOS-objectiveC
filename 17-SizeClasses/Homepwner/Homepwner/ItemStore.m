//
//  ItemStore.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

// Class Extension - see p. 161
@interface ItemStore()
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSURL          *itemArchiveURL;
@end

@implementation ItemStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
        
        NSArray *directories =
            [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                               inDomains:NSUserDomainMask];
        NSURL *documentDirectory = directories.firstObject;
        _itemArchiveURL = [documentDirectory URLByAppendingPathComponent:@"items.archive"];
        
        NSArray *loadedItems =
            [NSKeyedUnarchiver unarchiveObjectWithFile:self.itemArchiveURL.path];
        [_items addObjectsFromArray:loadedItems];
    }
    return self;
}

// MARK: - Item Management
- (NSArray *)allItems {
    return [self.items copy];
}

- (Item *)createItem {
    Item *newItem = [[Item alloc] initWithRandomValues];
    [self.items addObject:newItem];
    return newItem;
}

- (void)removeItem:(Item *)item {
    [self.items removeObject:item];
}

- (void)moveItemAtIndex:(NSUInteger)oldIndex
                toIndex:(NSUInteger)newIndex {
    
    if (oldIndex == newIndex) {
        return;
    }
    
    // Get a reference to the object being removed so it can be re-inserted
    Item *item = self.items[oldIndex];
    
    // Remove it from the array
    [self.items removeObjectAtIndex:oldIndex];
    
    // Insert it in new position
    [self.items insertObject:item atIndex:newIndex];
}

// MARK: - Saving/Loading

- (BOOL)saveChanges {
    NSLog(@"Saving the store to %@", self.itemArchiveURL);
    return [NSKeyedArchiver archiveRootObject:self.items
                                       toFile:self.itemArchiveURL.path];
}

@end
