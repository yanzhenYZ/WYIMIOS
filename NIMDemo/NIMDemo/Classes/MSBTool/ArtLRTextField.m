//
//  ArtLRTextField.m
//  ArtVideoWB
//
//  Created by zhouqiang on 2018/12/15.
//  Copyright © 2018 美术宝. All rights reserved.
//

#import "ArtLRTextField.h"

@implementation ArtLRTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    printf("\n%s",NSStringFromSelector(action).UTF8String);
    if (action == @selector(paste:)) {
        if (self.canPasteBlock) {
            return self.canPasteBlock();
        }
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
@end
