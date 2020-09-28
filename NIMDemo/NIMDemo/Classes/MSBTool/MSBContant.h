//
//  MSBContant.h
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 http://1v1k8s.meishubao.com/vip-app-default/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-dev/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-test/api/backend/api/login/
 http://1v1k8s.meishubao.com/vip-app-prod/api/backend/api/login/

 http://msi.yiqimeishu.com/vip-app-live/api/backend/api/login/
 
 第一个开发环境，第二个测试环境，第三个预发环境，最后两个生产环境

 
 
 
 网易云信测试环境配置
 appKey：d1ff2153e817bdac8e9a9351c29c107d
 appSecret：2aee63d802e2
 
 
 
 
 获取im信息的域名https://smbimtest.meishubao.com
 接口/im/getRegisterYxUserInfo
 界面我们自己先照着1对1的界面写个，聊天界面先用网易云信demo里面的
 
 这里有个展示需要注意一下，因为我们都是以群组的形式创建聊天，但是要求客户端展示会话列表里面是按个人聊天的样式来展示，就是cell里面头像是用户的头像，昵称是用户昵称，不是群组的头像和昵称，这块要注意处理下
 
 */
//是否网易测试环境
#define MNIMTEST true


#if MNIMTEST
#define MSBAPPKEY @"45c6af3c98409b18a84451215d0bdd6e"
#define MSBAPIURL @"https://app.netease.im/api"
#else
#define MSBAPPKEY @"d1ff2153e817bdac8e9a9351c29c107d"
#define MSBAPIURL @"https://smbimtest.meishubao.com"
#endif

inline static CGFloat artScaleFactor()
{
    // Frame缩放系数，原宽/高 * kFrameScaleFactor
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return 1.0;
    } else {
        return 0.8;
    }
}

#define kScreenScale [UIScreen mainScreen].scale
#define kScaleFactor artScaleFactor()
#define kArtLRScaleViewHeight   (50.f * kArtLRScaleFactor)//view单行高度
// 一般适配
#define kartIphoneScaleFactor artIphoneScaleFactor()

#define UI_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define kArtLRScalePageTop      (UI_IS_IPAD ? 150 : 76 * kArtLRScaleFactor) //page顶部间距 [小屏(320)下待UI配合处理]
#define kArtLRScalePageMargin   (UI_IS_IPAD ? 200 : 20.f) //page左右间距
#define kArtLRScaleFactor       (UI_IS_IPAD ? 1.0 : (CGRectGetWidth(UIScreen.mainScreen.bounds) < 375.f ? 0.86 : 1))

#define kArtLRSelectedColor     UIColorFromHexString(@"F24F4F")
#define kArtLRScaleFactor       (UI_IS_IPAD ? 1.0 : (CGRectGetWidth(UIScreen.mainScreen.bounds) < 375.f ? 0.86 : 1))
#define kArtLRScaleViewSpacing  (10.f * kArtLRScaleFactor)//view行距
#define kArtLRScaleButtonHeight (50.f * kArtLRScaleFactor)//大按钮高度
#define UIColorFromHexString(hex) [UIColor colorWithHexString:hex]
#define kArtLRScaleTitleFont    (20.f * kArtLRScaleFactor)//标题字体
static NSInteger kCheckCodeNumberMax = 6;
static NSInteger kPhoneNumberMin     = 7;
static NSInteger kPhoneNumberMax     = 11;
#define kArtLRScaleFontSize     (15.f * kArtLRScaleFactor)//输入框,普通按钮字体
#define kArtLRScaleButtonFont   (18.f * kArtLRScaleFactor)//大按钮圆角
#define kArtLRButtonTitleColor0 UIColorFromHexString(@"999999")
#define kArtLRButtonBgColor0    UIColorFromHexString(@"E5E5E5")
//选中(1<<2)
#define kArtLRButtonTitleColor4 UIColorFromHexString(@"ffffff")
#define kArtLRButtonBgColor4    UIColorFromHexString(@"F24F4F")
//高亮(1<<0)
#define kArtLRButtonTitleColor1 kArtLRButtonTitleColor0
#define kArtLRButtonBgColor1    UIColorFromHexString(@"cccccc")
//高亮(1<<0)+选中(1<<2)
#define kArtLRButtonBgColor5    UIColorFromHexString(@"cc292c")
#define kArtLRButtonTitleColor5 [UIColorFromHexString(@"ffffff") colorWithAlphaComponent:0.6]
