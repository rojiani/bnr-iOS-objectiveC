//
//  ViewController.m
//  WorldTrotter
//
//  Created by Rojiani, Navid on 4/18/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "ConversionViewController.h"

@interface ConversionViewController () <UITextFieldDelegate>

@property (nonatomic) IBOutlet UILabel *celsiusLabel;
@property (nonatomic) IBOutlet UITextField *fahrenheitField;
@property (nonatomic) double fahrenheitValue;
@property (nonatomic) double celsiusValue;

@end

@implementation ConversionViewController

- (IBAction)fahrenheitFieldEditingChanged:(UITextField *)textField {
    NSNumber *num = [self.numberFormatter numberFromString:textField.text];
    if (num != nil) {
        self.fahrenheitValue = num.doubleValue; // setFahrenheitValue --> updateCelsiusLabel
    } else {
        self.celsiusLabel.text = @"???";
    }
}

- (void)setFahrenheitValue:(double)fahrenheitValue {
    _fahrenheitValue = fahrenheitValue;
    [self updateCelsiusLabel];
}

- (void)setCelsiusValue:(double)celsiusValue {
    self.fahrenheitValue = celsiusValue * (9.0/5.0) + 32;
}

- (double)celsiusValue {
    return (self.fahrenheitValue - 32) * (5.0/9.0);
}

- (void)updateCelsiusLabel {
    // triggered by setFahrenheitValue
    
    // Boxing up the celsiusValue in a liternal NSNumber, so that you can
    // easily extract its stringValue
    // self.celsiusLabel.text = @(self.celsiusValue).stringValue;
    self.celsiusLabel.text = [self.numberFormatter
                                stringFromNumber:@(self.celsiusValue)];
}

/* Getter for Number Formatter */
- (NSNumberFormatter *)numberFormatter {
    static NSNumberFormatter *formatter = nil; // why static: p. 103
    if (formatter == nil) {
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.minimumFractionDigits = 0;
        formatter.maximumFractionDigits = 1;
    }
    return formatter;
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.fahrenheitField resignFirstResponder];
}

// MARK: - Text Field Delegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(nonnull NSString *)string {
    
    // Disable > 1 decimal
    NSRange existingRange = [textField.text rangeOfString:@"."];
    BOOL hasExistingDecimalSeparator = (existingRange.location != NSNotFound);
    NSRange newRange = [string rangeOfString:@"."];
    BOOL wantsNewDecimalSeparator = (newRange.location != NSNotFound);
    
    if (hasExistingDecimalSeparator && wantsNewDecimalSeparator) {
        return NO;
    }

    // Disable alphabetic characters (Bluetooth keyboard or pasting copied text)
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    NSRange inputLettersRange = [string rangeOfCharacterFromSet:letters];
    // NSLog(@"inputLettersRange: %@", NSStringFromRange(inputLettersRange));
    BOOL containsLetters = inputLettersRange.location != NSNotFound;
    // NSLog(@"contains letters: %d", containsLetters);
    if (containsLetters) {
        return NO;
    }
    
    return YES;
}

@end
