//
//  MovieStaticLibrary
//  MovieStaticLibrary
//
//  Created by Aloha Cool on 24/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#import "MovieStaticLibrary.h"

@implementation MovieStaticLibrary

-(NSString* ) getApiKey {
    // should be load in Keychain then c_myDecrypt
    NSString* encryptedKey = [self getApiKeyFromKeychain];
    char* apiKey = c_myDecrypt([encryptedKey UTF8String]);
    return [NSString stringWithUTF8String:apiKey];
}

-(NSString* ) getApiKeyFromKeychain {
    const char* apiKey = c_getApiKeyFromKeychain();
    return [NSString stringWithUTF8String:apiKey];
}

-(NSInteger) setApiKey:(NSString* ) plainKey {
    // should be store in keychain before c_myEncrypt
    char* encryptedKey = c_myEncrypt([plainKey UTF8String]);
    return c_setApiKey(encryptedKey);
}

-(struct MovieList) listMovieSorted:(NSString* ) json {
    struct MovieList movieList = c_sortListMovie([json UTF8String]);
    return movieList;
}

@end
