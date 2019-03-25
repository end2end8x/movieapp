//
//  MovieStaticLibrary.h
//  MovieStaticLibrary
//
//  Created by Aloha Cool on 24/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "BaseEncrypt.h"

@interface MovieStaticLibrary : NSObject

-(NSString*) getApiKey;
-(NSInteger) setApiKey:(NSString* ) plainKey;
-(struct MovieList) listMovieSorted:(NSString* ) json;

//-(void) helloCplus:(NSString* ) name;

@end
