//
//  BaseApi.m
//  MovieDynamicLibrary
//
//  Created by Aloha Cool on 23/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#import "BaseApi.h"
#import "MovieSort.h"
#import "MovieStaticLibrary/MovieStaticLibrary.h"

@implementation BaseApi

static NSString* baseUrl = @"https://api.themoviedb.org";

+(NSString* ) getApiKey:(NSString* )encryptedKey {
    MovieStaticLibrary* movieStatic = [[MovieStaticLibrary alloc] init];
    return [movieStatic getApiKey];
}

-(NSInteger) setApiKey:(NSString* ) plainKey {
    MovieStaticLibrary* movieStatic = [[MovieStaticLibrary alloc] init];
    return [movieStatic setApiKey:plainKey];
}

-(NSMutableArray* ) listMovieSorted:(NSString* ) json {
    MovieStaticLibrary* movieStatic = [[MovieStaticLibrary alloc] init];
    MovieList movieList = [movieStatic listMovieSorted:json];
    NSMutableArray* listMovie = [[NSMutableArray alloc] init];

    for (int i = 0; i < movieList.count; i++) {
        MovieSort *obj = [[MovieSort alloc] init];
        obj.vote_count = movieList.list[i].vote_count;
        obj.title = [NSString stringWithUTF8String:movieList.list[i].title];
        [listMovie addObject:obj];
        if(i >= 9) {
            break;
        }
    }
    return listMovie;
}

-(void) getJsonDataAsync:(NSString* )path withCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback {
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@api_key=%@", baseUrl, path, [BaseApi getApiKey:@""]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:callback] resume];
}

@end
