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


@end
