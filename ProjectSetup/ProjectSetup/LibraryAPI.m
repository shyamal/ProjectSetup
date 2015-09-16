//
//  LibraryAPI.m
//  ProjectSetup
//
//  Created by JKCS-Shyamal on 9/16/15.
//  Copyright (c) 2015 JKCS. All rights reserved.
//

#import "LibraryAPI.h"
#import "AFNetworking.h"

@implementation LibraryAPI{
    AFHTTPRequestOperationManager *manager;
}

+ (LibraryAPI*)sharedInstance
{
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

-(id)init{
    self = [super init];
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //[manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [appDelegate.userDefaults valueForKey:@"AccessToken"]] forHTTPHeaderField:@"Authorization"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json; charset=UTF-8"];
    
    NSLog(@"initialized");
    return self;
}

//user loging
-(void)userLogin:(NSString *)userName password:(NSString *)passwordString withBlock:(void (^)(NSArray *))block{
    NSLog(@"UserLogin");
    
    NSDictionary *detailDict = @{@"userName": userName,
                                 @"password": passwordString};
    
    NSDictionary *paramsDict = @{@"controller": @"User",
                                 @"action": @"logincheck",
                                 @"username": @"ranjana",
                                 @"request_data": detailDict};
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://www.api.getcolombo.com/codeapi.php/28e336ac6c9423d946ba02d19c6a2632/push"] parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* resultsArray = responseObject;
        block(resultsArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSDictionary *paramsDict = @{
                                     @"message": NSLocalizedString(@"message_connection_failed", nil),
                                     @"code": @"connectionFailed",
                                     @"status": @"FAILED"};
        //NSMutableArray *arrayCodigos = [NSMutableArray arrayWithArray:paramsDict];
        NSArray* resultsArray = [NSArray arrayWithObject:paramsDict];
        block(resultsArray);
    }];
    
    
}

@end
