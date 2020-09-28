//
//  MSBHttpTool.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBHttpTool.h"
#import <AFNetworking.h>

/**
 http://1v1k8s.meishubao.com/vip-app-default/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-dev/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-test/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-prod/api/backend/api/login/

 http://msi.yiqimeishu.com/vip-app-live/api/backend/api/login/
 
 第一个开发环境，第二个测试环境，第三个预发环境，最后两个生产环境
 */


static NSString *const MSB = @"http://1v1k8s.meishubao.com/vip-app-default/api/backend/api/login/";

@implementation MSBHttpTool

+ (void)msbLogin:(NSString *)username identity:(NSString *)password completion:(void (^)(NSDictionary *obj, NSError *error))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{
        @"mobile" : username,
        @"code" : password
    };
//    [manager POST:MSB parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MSBHttpTool getImInfo:@"1791474" identity:0 completion:completion];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (completion) {
//            completion(nil, error);
//        }
//    }];
    
    [MSBHttpTool getImInfo:@"1791474" identity:0 completion:^(NSDictionary *obj, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        } else {
            NSLog(@"success: %@", obj);
        }
    }];
    
}

+ (void)getImInfo:(NSString *)userId identity:(int)identity completion:(void (^)(NSDictionary *obj, NSError *error))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{
        @"userId" : userId,
        @"identity" : @(identity)
    };
    [manager POST:@"https://smbimtest.meishubao.com/im/getRegisterYxUserInfo" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}
@end
