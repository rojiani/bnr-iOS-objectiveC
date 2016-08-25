//
//  ItemCellTableViewCell.h
//  Homepwner
//
//  Created by Rojiani, Navid on 4/20/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (nonatomic) IBOutlet UILabel *valueLabel;

- (void)updateLabels;

@end
