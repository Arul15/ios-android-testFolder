//
//  URLConnection.m
//  ios-android-test
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import "URLConnection.h"

@implementation URLConnection
@synthesize delgateObject,urlResponseData;
@synthesize pStrSetIdentifier;

- (id) initWithMethodNameRequest:(NSMutableURLRequest *)requestArg delegate:(id)delegateArg identifier:(NSString *)checkIdentity{
    self = [super initWithRequest:requestArg delegate:self];
    pStrSetIdentifier=checkIdentity;
    if (self != nil) {
        self.delgateObject=delegateArg;
    }
    return self;
}

- (id) initWithMethodRequest:(NSMutableURLRequest *)requestArg delegate:(id)delegateArg{
    self = [super initWithRequest:requestArg delegate:self];
    if (self != nil) {
        self.delgateObject=delegateArg;
    }
    return self;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([pStrSetIdentifier isEqualToString:@"FootBallData"])
        [self.delgateObject APIReceivedFootBallData:urlResponseData];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:
(NSError *)error {
    urlResponseData = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(!urlResponseData){
        urlResponseData = [[NSMutableData alloc] init];
        [urlResponseData setLength:0];
    }
    [urlResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code = [httpResponse statusCode];
    NSLog(@"response code is %ld",(long)code);
    [urlResponseData setLength:0];
}

@end
