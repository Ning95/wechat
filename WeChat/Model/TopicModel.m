//
//  TopicModel.m
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import "TopicModel.h"

@implementation TopicModel

- (void)configWithDictionary:(NSDictionary *) dictionary: (NSArray *) cModels{
    #warning 注意类型是否匹配
    self.icon = [dictionary objectForKey:@"avatar"];
    self.userName = [dictionary objectForKey:@"userName"];
    self.content = [dictionary objectForKey:@"content"];
    self.commentModels = cModels;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.commentModels = [aDecoder decodeObjectForKey:@"commentModels"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.commentModels forKey:@"commentModels"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}
@end
