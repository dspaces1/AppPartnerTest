//
//  RESTfulHelper.m
//  IOSProgrammerTest
//
//  Created by Diego Urquiza on 10/8/15.
//  Copyright © 2015 AppPartner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RESTfulHelper.h"

@implementation RESTfulHelper

+(void)postRequestWithDictionary:(NSDictionary*) jsonParameter url:(NSString*)url completionBlock: (void (^)(NSError *, NSDictionary *))blockName
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager POST:url parameters:jsonParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseObj = responseObject;
        blockName(nil,responseObj);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blockName(error,nil);
    }];
}

@end