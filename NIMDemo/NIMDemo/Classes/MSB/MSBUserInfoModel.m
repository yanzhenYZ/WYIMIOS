//
//  MSBUserInfoModel.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBUserInfoModel.h"

@implementation MSBUserInfoModel
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        __id = [value intValue];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
