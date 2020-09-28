//
//  MSBUserInfoModel.h
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSBUserInfoModel : NSObject
@property (nonatomic, assign) int age;
@property (nonatomic, assign) NSInteger allocated;
@property (nonatomic, assign) NSInteger ban;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *cno;
@property (nonatomic, copy) NSString *cnoTel;
@property (nonatomic, assign) NSInteger cnoType;
@property (nonatomic, assign) NSInteger ctime;
@property (nonatomic, assign) NSInteger ddId;
@property (nonatomic, assign) NSInteger del;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger enableClass;
@property (nonatomic, assign) NSInteger fpAuto;
@property (nonatomic, assign) NSInteger handle;
@property (nonatomic, copy) NSString *handleInfo;
//id
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger isformal;
@property (nonatomic, assign) NSInteger job;
@property (nonatomic, assign) NSInteger jobNumber;
@property (nonatomic, assign) NSInteger jobStatus;
@property (nonatomic, assign) NSInteger jobtime;
@property (nonatomic, assign) NSInteger lastTime;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, assign) NSInteger official;
@property (nonatomic, copy) NSString *permissionTeamIds;
@property (nonatomic, assign) NSInteger permitCno;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, assign) NSInteger receptionNum;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, assign) NSInteger reserve;
@property (nonatomic, assign) NSInteger right;
@property (nonatomic, assign) NSInteger role;
@property (nonatomic, copy) NSString *roleIds;
@property (nonatomic, assign) NSInteger salesLeveln;
@property (nonatomic, assign) NSInteger saleslevel;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger startjob;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger stopJobTime;
@property (nonatomic, assign) NSInteger stopJobTimeEnd;
@property (nonatomic, assign) NSInteger teamid;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *teamids;
@property (nonatomic, assign) NSInteger title;
@property (nonatomic, assign) NSInteger tongji;
@property (nonatomic, assign) NSInteger tracknum;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *uemail;
@property (nonatomic, assign) NSInteger utime;
@property (nonatomic, copy) NSString *weixin;
@end

NS_ASSUME_NONNULL_END
