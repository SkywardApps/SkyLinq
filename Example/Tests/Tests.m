//
//  SkyLinqTests.m
//  SkyLinqTests
//
//  Created by undiwahn on 02/24/2018.
//  Copyright (c) 2018 undiwahn. All rights reserved.
//
@import XCTest;
@import SkyLinq;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConstructor
{
    SkyLinq* linq = [SkyLinq from:@[]];
    XCTAssertNotNil(linq, @"Constructor returned a nil result");
}

- (void)testConstructor_onNil_fail
{
    SkyLinq* linq = [SkyLinq from:nil];
    XCTAssertNil(linq, @"Constructor should have returned nil for a nil source");
}

- (void)testQuery
{
    NSArray* array = @[@"One", @"Two", @"Three"];
    SkyLinq* linq = array.query;
    XCTAssertTrue([linq isKindOfClass:SkyLinq.class], @"Query did not return a valid SkyLinq wrapper");
}

- (void)testSelect
{
    NSArray* array = @[@"One", @"Two", @"Three"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.select(^(NSString* item){
        return [item substringToIndex:1];
    });
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 3, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"O");
    XCTAssertEqualObjects(resultArray[1], @"T");
    XCTAssertEqualObjects(resultArray[2], @"T");
}

- (void)testSelectMany
{
    NSArray* sourceArray = @[
                                @[@"One", @"Two"],
                                @[@"Three", @"Four"]
                             ];
    SkyLinq* linq = sourceArray.query;
    SkyLinq* results = linq.selectMany(^(NSArray* item) {
        return item;
    });
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 4, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"One");
    XCTAssertEqualObjects(resultArray[1], @"Two");
    XCTAssertEqualObjects(resultArray[2], @"Three");
    XCTAssertEqualObjects(resultArray[3], @"Four");
}

- (void)testWhere
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.where(^(NSString* item){
        return [[item substringToIndex:1] isEqualToString:@"T"];
    });
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 2, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"Two");
    XCTAssertEqualObjects(resultArray[1], @"Three");
}

- (void)testGroupBy
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    NSDictionary* results = linq.groupBy(^(NSString* item){
        return [item substringToIndex:1] ;
    });
    XCTAssertNotNil(results[@"O"]);
    XCTAssertNotNil(results[@"T"]);
    XCTAssertNotNil(results[@"F"]);
    XCTAssertEqualObjects(results[@"O"][0], @"One");
    XCTAssertEqualObjects(results[@"F"][0], @"Four");
    XCTAssertEqualObjects(results[@"T"][0], @"Two");
    XCTAssertEqualObjects(results[@"T"][1], @"Three");
}

- (void)testGroupBy_nilKey_fail
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    XCTAssertThrows(linq.groupBy(^(NSString* item){
        return (id)nil;
    }));
}

- (void)testOrderBy
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.orderBy(^(NSString* item){return item;});
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 4, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"Four");
    XCTAssertEqualObjects(resultArray[1], @"One");
    XCTAssertEqualObjects(resultArray[2], @"Three");
    XCTAssertEqualObjects(resultArray[3], @"Two");
}

- (void)testOrderByDesc
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.orderByDesc(^(NSString* item){return item;});
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 4, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[3], @"Four");
    XCTAssertEqualObjects(resultArray[2], @"One");
    XCTAssertEqualObjects(resultArray[1], @"Three");
    XCTAssertEqualObjects(resultArray[0], @"Two");
}

- (void)testTake
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.take(2);
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 2, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"One");
    XCTAssertEqualObjects(resultArray[1], @"Two");
}

- (void)testTake_moreThanExist_success
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.take(6);
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 4, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"One");
    XCTAssertEqualObjects(resultArray[1], @"Two");
    XCTAssertEqualObjects(resultArray[2], @"Three");
    XCTAssertEqualObjects(resultArray[3], @"Four");
}

- (void)testSkip
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.skip(2);
    NSArray* resultArray = results.array;
    XCTAssertEqual(resultArray.count, 2, @"Incorrect result length");
    XCTAssertEqualObjects(resultArray[0], @"Three");
    XCTAssertEqualObjects(resultArray[1], @"Four");
}

- (void)testSkip_moreThanExist_success
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    SkyLinq* results = linq.skip(6);
    NSArray* resultArray = results.array;
    XCTAssertNotNil(resultArray);
    XCTAssertEqual(resultArray.count, 0, @"Incorrect result length");
}

- (void)testFirst
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    NSString* result = linq.first;
    XCTAssertEqualObjects(result, @"One");
}

- (void)testFirst_emptyCollection
{
    NSArray* array = @[];
    SkyLinq* linq = array.query;
    NSString* result = linq.first;
    XCTAssertNil(result);
}

- (void)testLast
{
    NSArray* array = @[@"One", @"Two", @"Three", @"Four"];
    SkyLinq* linq = array.query;
    NSString* result = linq.last;
    XCTAssertEqualObjects(result, @"Four");
}

- (void)testLast_emptyCollection
{
    NSArray* array = @[];
    SkyLinq* linq = array.query;
    NSString* result = linq.last;
    XCTAssertNil(result);
}

@end

