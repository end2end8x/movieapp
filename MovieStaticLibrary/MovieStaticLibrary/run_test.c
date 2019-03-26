//
//  run_test.c
//  MovieStaticLibrary
//
//  Created by Aloha Cool on 26/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "BaseEncrypt.h"

#define run_test(fn_name) \
printf("%s\n", #fn_name); \
fn_name()

void test_c_sortListMovie() {
    struct MovieList movieList = c_sortListMovie("{\"page\":1,\"total_results\":131343,\"total_pages\":6568,\"results\":[{\"vote_count\":158,\"id\":464504,\"video\":false,\"vote_average\":5.8,\"title\":\"A Madea Family Funeral\",\"popularity\":144.356,\"poster_path\":\"\/bOiHlY5JD8GLp7BvWdHkfEftzhQ.jpg\",\"original_language\":\"en\",\"original_title\":\"A Madea Family Funeral\",\"genre_ids\":[35],\"backdrop_path\":\"\/piGjUloiaq6qTpaDLisyDyEsx9i.jpg\",\"adult\":false,\"overview\":\"A joyous family reunion becomes a hilarious nightmare as Madea and the crew travel to backwoods Georgia, where they find themselves unexpectedly planning a funeral that might unveil unpleasant family secrets.\",\"release_date\":\"2019-03-01\"},{\"vote_count\":158,\"id\":464504,\"video\":false,\"vote_average\":5.8,\"title\":\"A Madea Family Funeral\",\"popularity\":144.356,\"poster_path\":\"\/bOiHlY5JD8GLp7BvWdHkfEftzhQ.jpg\",\"original_language\":\"en\",\"original_title\":\"A Madea Family Funeral\",\"genre_ids\":[35],\"backdrop_path\":\"\/piGjUloiaq6qTpaDLisyDyEsx9i.jpg\",\"adult\":false,\"overview\":\"A joyous family reunion becomes a hilarious nightmare as Madea and the crew travel to backwoods Georgia, where they find themselves unexpectedly planning a funeral that might unveil unpleasant family secrets.\",\"release_date\":\"2019-03-01\"}]}");
    
    assert(movieList.count == 2);
}

void test_c_myEncrypt() {
    assert(strcmp(c_myEncrypt("b"), "a") == 0);
}

void test_c_myDecrypt() {
    assert(strcmp(c_myDecrypt("a"), "b") == 0);
}

int main(int argc, char *argv[]) {
    run_test(test_c_sortListMovie);
    run_test(test_c_myEncrypt);
    run_test(test_c_myDecrypt);
    printf("\nOK\n");
    return 0;
}
