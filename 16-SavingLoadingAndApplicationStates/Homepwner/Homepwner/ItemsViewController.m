//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/19/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageStore.h"
#import "Item.h"
#import "ItemStore.h"
#import "ItemsViewController.h"
#import "ItemCell.h"


@interface ItemsViewController ()
@end

@implementation ItemsViewController

// MARK: - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.leftBarButtonItem = [self editButtonItem];
    }
    return self;
}

// MARK: - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // need to set row height for custom UITableViewCell based on A.L. constraints (p. 192)
    self.tableView.rowHeight = UITableViewAutomaticDimension;   // default
    self.tableView.estimatedRowHeight = 65; // setting estimatedRowHeight can improve performance
}

// Reload table view data, since it may have been altered in DetailViewController.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// Pass data (item, imageStore) between view controllers during segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
    // If the triggered segue is the "ShowItem" segue
    if ([segue.identifier isEqualToString:@"ShowItem"]) {
        // Figure out which row was just tapped
        NSInteger row = [self.tableView indexPathForSelectedRow].row;
        
        // Get the item at that row and pass it along to the segue's
        // destination view controller
        Item *item = self.itemStore.allItems[row];
        DetailViewController *dvc = (DetailViewController *)segue.destinationViewController;
        
        // Inject item & imageStore
        dvc.item = item;
        dvc.imageStore = self.imageStore;
    }
}

// MARK: - Table View Data Source and Delegate

// Number of rows
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.itemStore.allItems.count;
}

// Create or get recycled instance of UITableViewCell/ItemCell & configure.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Check the pool/queue of cells to see whether there is a cell that can be recycled.
    // Creates & returns a new one if not.
    ItemCell *cell =
        [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"
                                             forIndexPath:indexPath];
    
    // Update the labels in case the dynamic font sizes have changed recently
    [cell updateLabels];
    
    // Set the text on the cell with the description of the item that is at
    // the nth index of items, where n = row. This cell will appear in on the tableview
    Item *item = self.itemStore.allItems[indexPath.row]; // ...allItems[n]
    
    // Configure the cell w/ the item's properties
    cell.nameLabel.text = item.name;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
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
                                       // Remove the item from the itemStore
                                       [self.itemStore removeItem:item];

                                       // Delete the item's image from the imageStore
                                       [self.imageStore deleteImageForKey:item.itemKey];
               
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

@end
