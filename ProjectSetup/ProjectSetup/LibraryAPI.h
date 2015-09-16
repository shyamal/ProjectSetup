//
//  LibraryAPI.h
//  ProjectSetup
//
//  Created by JKCS-Shyamal on 9/16/15.
//  Copyright (c) 2015 JKCS. All rights reserved.
//
//  This class will handle all web service calls

#import <Foundation/Foundation.h>


@interface LibraryAPI : NSObject{
    
}


+ (LibraryAPI*)sharedInstance;
-(void)userLogin:(NSString *)userName password:(NSString *)passwordString withBlock:(void (^)(NSArray* results))block;

@end
