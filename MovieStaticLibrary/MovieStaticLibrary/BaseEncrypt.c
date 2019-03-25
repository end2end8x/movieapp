//
//  BaseEncrypt.c
//  MovieStaticLibrary
//
//  Created by Aloha Cool on 24/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#include "BaseEncrypt.h"
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>

char* apiKey = "";

char* c_getApiKeyFromKeychain(void) {
    // TODO
    return apiKey;
}

int c_setApiKey(const char* plainKey) {
    apiKey = malloc(strlen(plainKey) + 1);
    strcpy(apiKey, plainKey);
    return 0;
}

char* c_myEncrypt(const char* plainKey) {
    char* encryptedKey = malloc(strlen(plainKey) + 1);
    strcpy(encryptedKey, plainKey);
    for(int i = 0; i < strlen(plainKey); i++) {
        encryptedKey[i] = encryptedKey[i] - 1;
    }
    return encryptedKey;
}

char* c_myDecrypt(const char* encryptedKey) {
    char* plainKey = malloc(strlen(encryptedKey) + 1);
    strcpy(plainKey, encryptedKey);
    for(int i = 0; i < strlen(plainKey); i++) {
        plainKey[i] = plainKey[i] + 1;
    }
    return plainKey;
}

int cmpfunc (const void* a, const void* b) {
    struct Movie aa = *(struct Movie*) a;
    struct Movie bb = *(struct Movie*) b;
    return ( bb.vote_count - aa.vote_count );
}
            
struct MovieList c_sortListMovie(const char* json) {
    struct MovieList movieList;
    movieList.count = 0;
    struct Movie movies[20];
    char *results = strstr(json, "\"results\":");
    if(results != NULL && strlen(results) > 11) {
        results += 11;
    } else {
        return movieList;
    }
    char delim[] = "\"},{\"";
    char *ptr = strtok(results, delim);
    int count = 0;
    while(ptr != NULL) {
        ptr = strtok(0, delim);
        if(ptr != NULL && strcmp(ptr, "vote_count") == 0){
            ptr = strtok(0, delim);
            if(ptr != NULL && strlen(ptr) > 0) {
                ptr += 1;
            }
            movies[count].vote_count = atoi(ptr);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            ptr = strtok(0, delim);
            if(ptr != NULL && strcmp(ptr, "title") == 0) {
                ptr = strtok(0, delim);
                ptr = strtok(0, delim);
                if(ptr != NULL) {
                    movies[count].title = ptr;
                    count++;
                    if(count >= 20) {
                        break;
                    }
                }
            }
        }
    }
    qsort(movies, count, sizeof(struct Movie), cmpfunc);
    movieList.count = count;
    for (int i = 0; i < count; i++) {
        // printf("%d %s\n", movies[i].vote_count, movies[i].title);
        movieList.list[i].vote_count = movies[i].vote_count;
        movieList.list[i].title = malloc(strlen(movies[i].title) + 1);
        strcpy(movieList.list[i].title, movies[i].title);
    }
    return movieList;
}

int c_jsonMovieRead(const char *buf, struct Movie *obj) {
    return 0;
}

int checkAppCodeSignValid(const char* chain) {
    // Check .ipa Movie app was built by Owner Provisoning   ## return 0
    // It prevent this library can use by others             ## return 1
    return 0;
}

int main() {
    assert(strcmp(c_myEncrypt("b"), "a") == 0);
    assert(strcmp(c_myDecrypt("a"), "b") == 0);
    return 0;
}
