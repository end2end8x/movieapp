//
//  BaseApi.h
//  MovieDynamicLibrary
//
//  Created by Aloha Cool on 23/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseApi : NSObject

-(void) getJsonDataAsync:(NSString* )path withCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;

-(NSString*) getApiKey;
-(NSInteger) setApiKey:(NSString* ) plainKey;
-(struct MovieList) listMovieStruct:(NSString* ) json;
-(NSMutableArray* ) listMovieSorted:(NSString* ) json;

@end

NS_ASSUME_NONNULL_END
