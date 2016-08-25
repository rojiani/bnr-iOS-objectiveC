//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "Item.h"

@interface ItemsViewController ()
@end

@implementation ItemsViewController

// MARK: - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Put tableview below status bar.
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

// MARK: - Table View Data Source and Delegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.itemStore.allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Check the pool/queue of cells to see whether there is a cell that can be recycled.
    // Creates & returns a new one if not.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                                 forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item that is at
    // the nth index of items, where n = row. This cell will appear in on the tableview
    Item *item = self.itemStore.allItems[indexPath.row]; // ...allItems[n]
    
    // Configure the cell w/ the item's properties
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
    return cell;
}

// UITableViewDataSource Delegate
// Note: While the data is kept in ItemsStore, ItemsViewController is the table view's dataSource.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *item = self.itemStore.allItems[indexPath.row];
        
        NSString *title = [NSString stringWithFormat:@"Delete %@?", item.name];
        NSString *message = @"Are you sure that you want to delete this item?";
        
        UIAlertController *ac =
            [UIAlertController alertControllerWithTitle:title
                                                message:message
                                         preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        UIAlertAction *deleteAction =
            [UIAlertAction actionWithTitle:@"Delete"
                                     style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       // Remove the item from the store
                                       [self.itemStore removeItem:item];
                                       
                                       // Also remove its cell from the table view
                                       [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                                             withRowAnimation:UITableViewRowAnimationAutomatic];
                                    }];
        [ac addAction:cancelAction];
        [ac addAction:deleteAction];
        
        // Present the alert view controller modally
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self.itemStore moveItemAtIndex:sourceIndexPath.row
                            toIndex:destinationIndexPath.row];
}


// MARK: - Actions
- (IBAction)addNewItem:(id)sender {
    // Create a new item and add it to the ItemStore
    Item *newItem = [self.itemStore createItem];
    
    // Figure out where that item is in the array
    NSUInteger itemIndex = [self.itemStore.allItems indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    
    // Insert this row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)toggleEditingMode:(id)sender {
    if (self.editing) {
        // Change the text of the button
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change the text of the button to inform the user
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // Turn on editing mode
        [self setEditing:YES animated:YES];
    }
}

@end
