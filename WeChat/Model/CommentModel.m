//
//  CommentModel.m
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import "CommentModel.h"

@implementation CommentModel

- (NSString *) all
{
    if (_all == nil) {
        
        if (self.to && self.to.length > 0) {
            _all = [NSString stringWithFormat:@"%@ 回复 %@: %@", self.from, self.to, self.content];

        }
        else
        {
            _all = [NSString stringWithFormat:@"%@: %@", self.from, self.content];

        }
        
    }
    return _all;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.from = [aDecoder decodeObjectForKey:@"from"];
        self.to = [aDecoder decodeObjectForKey:@"to"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.all = [aDecoder decodeObjectForKey:@"all"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.from forKey:@"from"];
    [aCoder encodeObject:self.to forKey:@"to"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.all forKey:@"all"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
