//
//  Friend.m
//  WeChat
//
//  Created by Chenning on 2021/5/8.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initFriendInfo:(NSString *)avatarInfo andName:(NSString *) userNameInfo andContent:(NSString *) contentInfo {
    self = [super init];
    if (self) {
        avatar = avatarInfo;
        userName = userNameInfo;
        content = contentInfo;
    }
    return self;
}

- (NSString*) getAvatar {
    return avatar;
}
- (NSString*) getUserName{
    return userName;
}
- (NSString*) getContent{
    return content;
}

@end
