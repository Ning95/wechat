//
//  Friend.h
//  WeChat
//
//  Created by Chenning on 2021/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Friend : NSObject {
    NSString *avatar;
    NSString *userName;
    NSString *content;
}

- (instancetype)initFriendInfo:(NSString *)avatarInfo andName:(NSString *) userNameInfo andContent:(NSString *) contentInfo;

- (NSString*) getAvatar;
- (NSString*) getUserName;
- (NSString*) getContent;
@end

NS_ASSUME_NONNULL_END
