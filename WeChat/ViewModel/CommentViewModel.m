//
//  CommentViewModel.m
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import "CommentViewModel.h"
#import <UIKit/UIKit.h>
#import "CommentModel.h"

@class CommentModel;
@implementation CommentViewModel

- (void) setCommentModel:(CommentModel *)commentModel {
    _commentModel = commentModel;
    CGFloat margin = 5;
    
    CGFloat contentLabelX = 0;
    CGFloat contentLabelY = 0;
    CGFloat contentLabelW = self.maxW - 2 * margin;
    CGFloat contentLabelH = 0;
    
//    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
//    para.lineSpacing = 2;
//    NSDictionary *attr = @{
//                            NSParagraphStyleAttributeName: para,
//                            NSFontAttributeName: [UIFont systemFontOfSize:14],
//                            NSForegroundColorAttributeName: [UIColor colorWithRed:46/256.0 green:46/256.0 blue:46/256.0 alpha:1]
//                           };
    
//    self.contentAttributedString = [[NSAttributedString alloc] initWithString:commentModel.all attributes:attr];
    _contentString = commentModel.all;
    UIFont *commentFont = [UIFont systemFontOfSize:12.0];
    contentLabelH = [self.contentString boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:commentFont} context:nil].size.height;
    
    self.contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    self.cellHeight = CGRectGetMaxY(self.contentLabelF) + 5;
    // NSLog(@"");
}
@end
