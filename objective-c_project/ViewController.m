//
//  ViewController.m
//  objective-c_project_test
//
//  Created by Lucas on 09/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultTextField;

@end

@implementation ViewController

- (IBAction)calculateTapped:(UIButton *)sender {
    [self tryCalculate];
}

- (void)tryCalculate {
    if (![self checkIfCanCalculate: self.firstTextField.text secondValue: self.secondTextField.text]) { return; }
    
    [self calculate: [self convertStringToInt: self.firstTextField.text] secondValue: [self convertStringToInt: self.secondTextField.text]];
}

- (void)calculate:(int)firstValue secondValue:(int)secondValue {
    [self showResult: @(firstValue * secondValue).stringValue];
}

- (void)showResult:(NSString *)result {
    [self.resultTextField setText: result];
}

- (bool)checkIfCanCalculate:(NSString *)firstValue secondValue:(NSString *)secondValue {
    if (![self validateStringToInt: firstValue] ||
        ![self validateStringToInt: secondValue]) {
        return false;
    }
    return true;
}

- (bool)validateStringToInt:(NSString *)string {
    return ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound);
}

- (int)convertStringToInt:(NSString *)string {
    return [string intValue];
}

@end
