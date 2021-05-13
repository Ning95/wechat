//
//  TopicCellViewModel.m
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import "TopicCellViewModel.h"
#import "TopicModel.h"
#import "CommentModel.h"
#import "CommentViewModel.h"

@implementation TopicCellViewModel

- (void)setTopicModel:(TopicModel *)topicModel
{
    _topicModel = topicModel;
    
    CGFloat margin = 10;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    
    //图片大小位置设置
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconWH = 40;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //名字大小位置设置
    CGFloat nameLabelX = CGRectGetMaxX(self.iconF) + margin;
    CGFloat nameLabelW = 60;
    CGFloat nameLabelH = 30;
    
    //朋友圈内容大小位置设置
    CGFloat contentLabelX = nameLabelX;
    CGFloat contentLabelW = contentW - margin - iconWH;
    CGFloat contentLabelH = 0;
    
    UIFont *contentLabelFont = [UIFont systemFontOfSize:14.0];
    contentLabelH = [topicModel.content boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentLabelFont} context:nil].size.height + margin * 2;
    
    //评论区大小设置
    CGFloat tableViewX = contentLabelX;
    CGFloat tableViewW = contentLabelW;
    CGFloat tableViewH = 0;
    
    NSArray *commentModels = topicModel.commentModels;
    
    NSMutableArray *mutableVMs = [NSMutableArray array];
    if (commentModels.count > 0) {
        for (int i = 0; i < commentModels.count; i++) {
            CommentViewModel *commentViewModel = [[CommentViewModel alloc] init];
            commentViewModel.maxW = tableViewW;
            commentViewModel.commentModel = commentModels[i];
            
            tableViewH += commentViewModel.cellHeight;
            [mutableVMs addObject:commentViewModel];
        }
    }
    self.commentCellViewModels = [mutableVMs copy];
    
    
    if (nameLabelH > 0) {
        self.cellHeight += margin;
        self.nameLabelF = CGRectMake(nameLabelX, self.cellHeight, nameLabelW, nameLabelH);
        self.cellHeight += nameLabelH;
    }
    
    if (contentLabelH > 0) {
        self.cellHeight += margin * 0.5;
        self.contentF = CGRectMake(contentLabelX, self.cellHeight, contentLabelW, contentLabelH);
        self.cellHeight += contentLabelH;
    }
    
    if (tableViewH > 0) {
        self.cellHeight += margin * 0.5 ;
        self.tableviewF = CGRectMake(tableViewX, self.cellHeight, tableViewW, tableViewH);
        self.cellHeight += tableViewH;
    }
    
    self.cellHeight += margin * 0.5;
}

@end
