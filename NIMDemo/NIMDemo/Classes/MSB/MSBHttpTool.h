//
//  MSBHttpTool.h
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USEMSB 1

#if USEMSB
#define APPKEY @"d1ff2153e817bdac8e9a9351c29c107d"
#else
#define APPKEY @"45c6af3c98409b18a84451215d0bdd6e"
#endif
/**
 NTESLoginViewController - > onTouchLogin
 */

@interface MSBHttpTool : NSObject
+ (void)msbLogin:(NSString *)username identity:(NSString *)password completion:(void (^)(NSDictionary *obj, NSError *error))completion;
@end

