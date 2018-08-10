//
//  objective_c_project_testTests.m
//  objective-c_project_testTests
//
//  Created by Lucas on 09/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface objective_c_project_testTests : XCTestCase

@end

@implementation objective_c_project_testTests {
    ViewController *controller;
}

- (void)setUp {
    [super setUp];
    controller = [[ViewController alloc] init];
}

- (void)testCalculateTapped {
    [controller calculateTapped: [[UIButton alloc] init]];
}

- (void)testTryCalculate {
    [controller tryCalculate];
}

- (void)testCalculate {
    [controller calculate: 20 secondValue: 1000];
}

- (void)testShowResult {
    [controller showResult: @"2000"];
}

- (void)testCheckIfCanCalculateSuccesfully {
    XCTAssertTrue([controller checkIfCanCalculate:@"123" secondValue:@"100"], @"Convertion of a string to int successfully");
    XCTAssertTrue([controller checkIfCanCalculate:@"2004224" secondValue:@"100000"], @"Convertion of a string to int successfully");
}

- (void)testCheckIfCanCalculateFailure {
    XCTAssertFalse([controller checkIfCanCalculate:@"SABADAO" secondValue:@"10"], @"Convertion of SABADAO to int fail, you must enter only int values.");
    XCTAssertFalse([controller checkIfCanCalculate:@"quatro321" secondValue:@"1010"], @"Convertion of 123quatro56 to int fail, you must enter only int values.");
}

- (void)testConvertStringToIntSuccesfully {
    XCTAssertTrue([controller convertStringToInt:@"123"], @"Convertion of a string to int successfully");
    XCTAssertTrue([controller convertStringToInt:@"2004224"], @"Convertion of a string to int successfully");
}

- (void)testConvertStringToIntFailure {
    XCTAssertFalse([controller convertStringToInt:@"SABADAO"], @"Convertion of SABADAO to int fail, you must enter only int values.");
    XCTAssertFalse([controller convertStringToInt:@"quatro321"], @"Convertion of 123quatro56 to int fail, you must enter only int values.");
}

- (void)testValidateStringToInt {
    XCTAssertTrue([controller validateStringToInt:@"91"], @"String with valid int value.");
    XCTAssertFalse([controller validateStringToInt:@"123quatro"], @"String with invalid value.");
}

@end
