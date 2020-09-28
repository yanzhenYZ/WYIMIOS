//
//  MSBHttpTool.h
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NTESLoginViewController - > onTouchLogin
 */

@interface MSBHttpTool : NSObject
+ (void)msbLogin:(NSString *)username identity:(NSString *)password completion:(void (^)(NSDictionary *obj, NSError *error))completion;
@end

