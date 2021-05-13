//
//  MineCellViewModel.m
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import "MineCellViewModel.h"
#import "MineModel.h"

@implementation MineCellViewModel

- (void)setMineModel:(MineModel *)mineModel
{
    _mineModel = mineModel;

    //背景图片大小位置设置
    CGFloat backgroundX = 0;
    CGFloat backgroundY = 0;
    CGFloat backgroundW = [UIScreen mainScreen].bounds.size.width;
    CGFloat backgroundH = 260;
    self.mineBackgroundF = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
    self.cellHeight += backgroundH;
    
    
    //头像图片大小位置设置
    CGFloat headerWH = 60;
    CGFloat headerX = [UIScreen mainScreen].bounds.size.width - headerWH - 10;
    CGFloat headerY = backgroundH - (headerWH * 2 / 3);
    self.headerF = CGRectMake(headerX, headerY, headerWH, headerWH);
    
    //名字大小位置设置
    CGFloat nameLabelW = 50;
    CGFloat nameLabelH = 30;
    CGFloat nameLabelX = [UIScreen mainScreen].bounds.size.width - headerWH - nameLabelW - 10;
    CGFloat nameLabelY = backgroundH - nameLabelH;
    self.nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    self.cellHeight += 60;
}
@end
