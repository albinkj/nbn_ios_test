//
//  EarthQuakeTests.m
//  EarthQuakeTests
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EQlistingViewController.h"
#import "EQMapViewController.h"

@interface EarthQuakeTests : XCTestCase
@property EQlistingViewController *eqListingToTest;
@property EQMapViewController *eqMapToTest;

@end

@implementation EarthQuakeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _eqListingToTest = [[EQlistingViewController alloc]init];
    _eqMapToTest = [[EQMapViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetData{
    [_eqListingToTest setData];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Dummy expectation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssert(self->_eqListingToTest.mEQdDetailsArray.count > 0, @"Data source has populated array after initializing");
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
}

- (void)testGetTime{
    NSString *time = [_eqListingToTest getTime:1557208491360];
    XCTAssert(time != nil && ![time isEqualToString:@""], @"Data source has populated time");
}

- (void)testLoadMap{
    NSMutableArray *coordinates = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithDouble:-116.55],[NSNumber numberWithDouble:33.4496667], nil];
    
    NSMutableDictionary *geometryDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:coordinates,@"coordinates",  nil];
    
    NSMutableDictionary *propertiesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"16km SE of Anza, CA",@"place",  nil];
    
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:propertiesDictionary,@"properties",geometryDictionary, @"geometry",  nil];

    _eqMapToTest.mEQdeatils = finalDictionary;
    [_eqMapToTest loadMap];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Dummy expectation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssert(self->_eqMapToTest.mMapView.annotations == nil, @"Map with specefic loaction notation loaded.");
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
