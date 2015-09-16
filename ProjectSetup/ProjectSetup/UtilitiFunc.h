//
//  UtilitiFunc.h
//  QuickPay
//
//  Created by JKCS-Shyamal on 11/11/14.
//  Copyright (c) 2014 JKCS-Shyamal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UtilitiFunc : NSObject

+ (UtilitiFunc*)sharedInstance;
-(BOOL)isInternetAvailable;
-(NSDictionary*) getWhiteLabelDetails;
-(NSString*) getMessageCodesDetails:(NSString*) code;
-(BOOL)checkEmail:(NSString*) emailID;
-(BOOL) IsValidEmail:(NSString *)checkString;

//- (UIImage *)addBorderToImage:(UIImage *)image;
-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;

@end
