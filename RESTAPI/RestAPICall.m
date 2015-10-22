//
//  RestAPICall.m
//  ios-android-test
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import "RestAPICall.h"


@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end

@implementation RestAPICall {
    

}

NSString *pStrRequestUrl;

#pragma mark - Genearate Request


+(NSMutableURLRequest *)FootBalldata:(NSString*)postString {
    NSLog(@"11111111111");
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc] init];
    NSString *pStrLegalURLString =[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //Or your String Encoding;
    theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:pStrLegalURLString]];
    
    return theRequest;

}


@end
