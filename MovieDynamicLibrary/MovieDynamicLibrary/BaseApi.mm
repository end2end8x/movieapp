//
//  BaseApi.m
//  MovieDynamicLibrary
//
//  Created by Aloha Cool on 23/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#include <Security/Security.h>
#import "BaseApi.h"
#import "MovieSort.h"
#import <MovieStaticLibrary/BaseEncrypt.h>

@implementation BaseApi

static NSString* baseUrl = @"https://api.themoviedb.org";

-(NSString* ) getApiKey {
    NSString* encryptedKey = [self loadKeychain:@"TheMovieDB_ApiKey"];
    char* apiKey = c_myDecrypt([encryptedKey UTF8String]);
    return [NSString stringWithUTF8String:apiKey];
}

-(NSInteger) setApiKey:(NSString* ) plainKey {
    char* encryptedKey = c_myEncrypt([plainKey UTF8String]);
    [self saveKeychain:[NSString stringWithUTF8String:encryptedKey] withAccount:@"TheMovieDB_ApiKey"];
    return c_setApiKey(encryptedKey);
}

-(NSMutableDictionary*) dictionaryWithAccount:(NSString*)account {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier] ?: @"com.example.TheMovieDB";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:(__bridge id) kSecClassGenericPassword forKey: (__bridge NSString *) kSecClass];
    [dict setValue:bundleIdentifier forKey: (__bridge NSString *) kSecAttrService];
    [dict setValue:account forKey: (__bridge NSString *) kSecAttrAccount];
    [dict setValue:(__bridge id) kSecAttrAccessibleWhenUnlocked forKey: (__bridge NSString *) kSecAttrAccessible];
    return dict;
}

-(NSInteger) saveKeychain:(NSString*)apiKey withAccount:(NSString*)account {
    NSMutableDictionary* dict = [self dictionaryWithAccount:account];
    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
    NSLog(@"saveApiKey SecItemDelete OSStatus %d", (int)err);
    NSData* data = [apiKey dataUsingEncoding:NSUTF8StringEncoding];
    [dict setValue:data forKey: (__bridge NSString *) kSecValueData];
    err = SecItemAdd((__bridge CFDictionaryRef) dict, NULL);
    NSLog(@"saveApiKey SecItemAdd OSStatus %d", (int)err);
    return (int)err;
}

-(NSString*) loadKeychain:(NSString*)account {
    NSMutableDictionary* dict = [self dictionaryWithAccount:account];
    [dict setValue:(__bridge id)(kCFBooleanTrue) forKey: (__bridge NSString *) kSecReturnData];
    [dict setValue:(__bridge id)(kSecMatchLimitOne) forKey: (__bridge NSString *) kSecMatchLimit];
    CFDictionaryRef foundCF;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef) dict, (CFTypeRef*)&foundCF);
    NSLog(@"getApiKeyWithService OSStatus %d", (int)err);
    NSData* found = (__bridge NSData*)(foundCF);
    if (!found) return nil;
    NSString* apiKey = [[NSString alloc] initWithData:found encoding:NSUTF8StringEncoding];
    return apiKey;
}

-(NSMutableArray* ) listMovieSorted:(NSString* ) json {
    struct MovieList movieList = c_sortListMovie([json UTF8String]);
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

-(struct MovieList) listMovieStruct:(NSString* ) json {
    struct MovieList movieList = c_sortListMovie([json UTF8String]);
    return movieList;
}

-(void) getJsonDataAsync:(NSString* )path withCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback {
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@api_key=%@", baseUrl, path, [self getApiKey]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:callback] resume];
}

@end
