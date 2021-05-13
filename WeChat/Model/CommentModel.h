//
//  CommentModel.h
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property(nonatomic, copy) NSString *from;
@property(nonatomic, copy) NSString *to;
@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *all;

@end

NS_ASSUME_NONNULL_END
