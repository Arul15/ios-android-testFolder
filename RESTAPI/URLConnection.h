//
//  URLConnection.h
//  ios-android-test
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface URLConnection : NSURLConnection {
    NSMutableData *urlResponseData;
    NSString *pStrSetIdentifier;
    id delgateObject;

}
@property(nonatomic,retain)NSMutableData *urlResponseData;
@property(nonatomic,retain)id delgateObject;
@property(nonatomic,retain)NSString *pStrSetIdentifier;

-(id)initWithMethodNameRequest:(NSMutableURLRequest *)requestArg delegate:(id)delegateArg identifier:(NSString *)checkIdentity;
- (id)initWithMethodRequest:(NSMutableURLRequest *)requestArg delegate:(id)delegateArg;

@end
