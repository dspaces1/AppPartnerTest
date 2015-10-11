//
//  RESTfulHelper.h
//  IOSProgrammerTest
//
//  Created by Diego Urquiza on 10/8/15.
//  Copyright © 2015 AppPartner. All rights reserved.
//

#ifndef RESTfulHelper_h
#define RESTfulHelper_h

@interface RESTfulHelper : NSObject
+(void)doesSomething;
+(void)postRequestWithDictionary:(NSDictionary*) jsonParameter url:(NSString*)url completionBlock: (void (^)(NSError *, NSDictionary *))blockName;
@end

#endif /* RESTfulHelper_h */
