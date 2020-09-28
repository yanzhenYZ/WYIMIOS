//
//  ArtLRTextField.h
//  ArtVideoWB
//
//  Created by zhouqiang on 2018/12/15.
//  Copyright © 2018 美术宝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtLRTextField : UITextField
@property (nonatomic,  copy) BOOL(^canPasteBlock)(void);
@end

NS_ASSUME_NONNULL_END
