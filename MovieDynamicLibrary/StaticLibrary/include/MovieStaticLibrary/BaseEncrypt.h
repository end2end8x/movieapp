//
//  BaseEncrypt.h
//  MovieStaticLibrary
//
//  Created by Aloha Cool on 24/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#ifndef BaseEncrypt_h
#define BaseEncrypt_h

#include <stdio.h>

#endif /* BaseEncrypt_h */

#if defined __cplusplus
extern "C" {
#endif
    
struct Movie {
    const char* title;
    int vote_count;
};
    
struct MovieList {
    int count;
    struct Movie list[20];
};
    
char* c_getApiKeyFromKeychain(void);
    
int c_setApiKey(const char* plainKey);
    
char* c_myEncrypt(const char* plainKey);

char* c_myDecrypt(const char* encryptedKey);
    
struct MovieList c_sortListMovie(const char* json);

int c_jsonMovieRead(const char *buf, struct Movie *myobj);

#if defined __cplusplus
};
#endif
