//
//  MovieDynamicLibraryTests.m
//  MovieDynamicLibraryTests
//
//  Created by Aloha Cool on 23/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MovieDynamicLibrary/BaseApi.h>

@interface MovieDynamicLibraryTests : XCTestCase

@property (nonatomic) BaseApi* baseApi;

@end

@implementation MovieDynamicLibraryTests

//@pro

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.baseApi = [[BaseApi alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}

- (void)testListMovieSorted {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSMutableArray* array = [ _baseApi listMovieSorted:@"{\"page\":1,\"total_results\":131343,\"total_pages\":6568,\"results\":[{\"vote_count\":158,\"id\":464504,\"video\":false,\"vote_average\":5.8,\"title\":\"A Madea Family Funeral\",\"popularity\":144.356,\"poster_path\":\"\/bOiHlY5JD8GLp7BvWdHkfEftzhQ.jpg\",\"original_language\":\"en\",\"original_title\":\"A Madea Family Funeral\",\"genre_ids\":[35],\"backdrop_path\":\"\/piGjUloiaq6qTpaDLisyDyEsx9i.jpg\",\"adult\":false,\"overview\":\"A joyous family reunion becomes a hilarious nightmare as Madea and the crew travel to backwoods Georgia, where they find themselves unexpectedly planning a funeral that might unveil unpleasant family secrets.\",\"release_date\":\"2019-03-01\"},{\"vote_count\":158,\"id\":464504,\"video\":false,\"vote_average\":5.8,\"title\":\"A Madea Family Funeral\",\"popularity\":144.356,\"poster_path\":\"\/bOiHlY5JD8GLp7BvWdHkfEftzhQ.jpg\",\"original_language\":\"en\",\"original_title\":\"A Madea Family Funeral\",\"genre_ids\":[35],\"backdrop_path\":\"\/piGjUloiaq6qTpaDLisyDyEsx9i.jpg\",\"adult\":false,\"overview\":\"A joyous family reunion becomes a hilarious nightmare as Madea and the crew travel to backwoods Georgia, where they find themselves unexpectedly planning a funeral that might unveil unpleasant family secrets.\",\"release_date\":\"2019-03-01\"}]}"];
    XCTAssertEqual(array.count , 2);
}

- (void)testGetSetApiKey {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self.baseApi setApiKey:@"a"];
    NSString* apiKey = [self.baseApi getApiKey];
    XCTAssertTrue([apiKey isEqualToString:@"a"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
