//
//  TopicModel.h
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopicModel : NSObject <NSSecureCoding>

@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, strong) NSArray *commentModels;


- (void)configWithDictionary:(NSDictionary *)dictionary :(NSArray *) commentModels;
@end

NS_ASSUME_NONNULL_END
