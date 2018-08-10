//
//  ViewController.h
//  objective-c_project_test
//
//  Created by Lucas on 09/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)calculateTapped:(UIButton *)sender;
- (void)tryCalculate;
- (void)calculate:(int)firstValue secondValue:(int)secondValue;
- (void)showResult:(NSString *)result;
- (bool)checkIfCanCalculate:(NSString *)firstValue secondValue:(NSString *)secondValue;
- (bool)validateStringToInt:(NSString *)string;
- (int)convertStringToInt:(NSString *)string;

@end

