//
//  UtilitiFunc.m
//  QuickPay
//
//  Created by JKCS-Shyamal on 11/11/14.
//  Copyright (c) 2014 JKCS-Shyamal. All rights reserved.
//

#import "UtilitiFunc.h"
#import "Reachability.h"
#import "AppDelegate.h"

@implementation UtilitiFunc{
    AppDelegate *appDelegate;
}

+ (UtilitiFunc*)sharedInstance
{
    static UtilitiFunc *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UtilitiFunc alloc] init];
    });
    return _sharedInstance;
}

-(id)init{
    self = [super init];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"initialized");
    return self;
}

-(BOOL)isInternetAvailable
{
    BOOL isAvalable=NO;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable)
    {
        isAvalable=YES;
    }
    else
    {
        isAvalable=NO;
    }
    return isAvalable;
}

-(NSString *)getMainUrl{
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"AO.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"AO" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    // NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!plistDict)
    {
        NSLog(@"Error reading plist: %@, format", errorDesc);
    }
    // assign values
    return [plistDict objectForKey:@"MAIN_URL"];
}

-(NSDictionary *)getServerAcess{
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Server.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"Server" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    // NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!plistDict)
    {
        NSLog(@"Error reading plist: %@, format", errorDesc);
    }
    
    // assign values
    return plistDict;
}

-(NSDictionary *)getWhiteLabelDetails{
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"White_label.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"White_label" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    // NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!plistDict)
    {
        NSLog(@"Error reading plist: %@, format", errorDesc);
    }
    
    // assign values
    return plistDict;
}

-(NSString *)getMessageCodesDetails:(NSString *)code{
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"ErrorCode.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCode" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    // NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!plistDict)
    {
        NSLog(@"Error reading plist: %@, format", errorDesc);
    }
    
    NSString *message = [plistDict valueForKey:code];
    NSLog(@"Error reading plist: %@, format", message);
    // assign values
    return message;
}


-(BOOL)checkEmail:(NSString *)emailID{
    NSString *email = emailID;
    NSString *emailExpression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSError *nullError = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:emailExpression options:NSRegularExpressionCaseInsensitive error:&nullError];
    NSUInteger  checkEmail = [regularExpression numberOfMatchesInString:emailID options:0 range:NSMakeRange(0, email.length)];
    //println("email \(checkEmail)")
    if (checkEmail == 0){
        return NO;
    }else{
        return YES;
    }
}

-(BOOL) IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:checkString] == YES){
        return YES;
    }
    else
    {
        UIAlertView *rechableAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"incorrect_format_OrgInfo", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
        [rechableAlert show];
        return NO;
    }
}



-(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
