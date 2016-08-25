//
//  DetailViewController.m
//  Homepwner
//
//  Created by Rojiani, Navid on 4/20/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "ImageStore.h"

@interface DetailViewController ()
    <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *serialNumberField;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UILabel     *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

// MARK: - Accessors

// Set item property, and set the NavBar title to the item name
- (void)setItem:(Item *) item {
    _item = item;
    self.navigationItem.title = item.name;
}

// MARK: - View Lifecycle

// Initialize UI from item properties
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.nameField.text = self.item.name;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text =
        [[self valueFormatter] stringFromNumber:@(self.item.valueInDollars)];
    self.dateLabel.text =
        [[self dateFormatter] stringFromDate:self.item.dateCreated];
    
    // Display image if one exists for the item
    NSString *key = self.item.itemKey;
    UIImage *imageToDisplay = [self.imageStore imageForKey:key];
    self.imageView.image = imageToDisplay;
    
}

// Update the item's properties from the edited fields, so that they are saved
// and ItemsViewController will reflect changes to item
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Clear the first responder
    [self.view endEditing:YES];
    
    // Update the item's properties from the text fields
    self.item.name = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    NSNumber *numberInDollars = [[self valueFormatter] numberFromString:self.valueField.text];
    self.item.valueInDollars = numberInDollars.intValue;
}


// MARK: - Formatters

- (NSNumberFormatter *)valueFormatter {
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.minimumFractionDigits = 2;
        formatter.maximumFractionDigits = 2;
    });
    return formatter;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    });
    return formatter;
}

// MARK: - Actions

// Dismiss keyboard
- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender {
    UIImagePickerController *ipc = [UIImagePickerController new];
    
    // If the device has a camera, take a picture.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else { // Otherwise, just pick a photo from the library.
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    ipc.delegate = self; // set UIImagePickerControllerDelegate
    
    // Put the picker on the screen (present the UIImagePickerController modally)
    [self presentViewController:ipc animated:YES completion:nil];
}

// MARK: - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// MARK: - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image from the info dictionary
    UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    
    // Store the image in the ImageStore by the item's itemKey
    [self.imageStore setImage:image forKey:self.item.itemKey];
    
    // Put the image on the screen in the image view
    self.imageView.image = image;
    
    // Dismiss the image picker now that you're done with it
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
