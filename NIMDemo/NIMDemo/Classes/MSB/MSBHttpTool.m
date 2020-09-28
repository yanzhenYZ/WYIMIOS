//
//  MSBHttpTool.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBHttpTool.h"
#import <AFNetworking.h>
#import "MSBUserInfoModel.h"

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
    manager.requestSerializer.timeoutInterval = 10;
    NSDictionary *params = @{
        @"mobile" : username,
        @"password" : password
    };
    [manager POST:MSB parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int code = [responseObject[@"code"] intValue];
        if (code == 0 || code == 200) {
            NSDictionary *user = responseObject[@"payload"][@"user"];
            MSBUserInfoModel *model = [[MSBUserInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:user];
            [self getImInfo:[NSString stringWithFormat:@"%ld", model._id] identity:model.title completion:completion];
        } else {
            if (completion) {
                NSError *error = [NSError errorWithDomain:@"登录失败" code:code userInfo:@{}];
                completion(nil, error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

+ (void)getImInfo:(NSString *)userId identity:(int)identity completion:(void (^)(NSDictionary *obj, NSError *error))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
#if 1
    NSDictionary *params = @{
        @"userId" : userId,
        @"identity" : @(identity)
    };
#else
    NSDictionary *params = @{
        @"userId" : @"3625590",
        @"identity" : @(1)
    };
#endif
    NSLog(@"getInfo:%@", params);
    [manager GET:@"https://smbimtest.meishubao.com/im/getRegisterYxUserInfo" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
