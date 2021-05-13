//
//  MineTableViewCell.m
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import "MineTableViewCell.h"
#import "MineModel.h"
#import "MineCellViewModel.h"

@interface MineTableViewCell()<UITableViewDelegate, UITableViewDataSource>

    @property(nonatomic, strong) UIImageView *mineBackgroundView;
    @property(nonatomic, strong) UIImageView *headerView;
    @property(nonatomic, strong) UITextView *mineView;
@end


@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mineBackgroundView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mineBackgroundView];
        
        _headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headerView];
        
        _mineView = [[UITextView alloc] init];
        [self.contentView addSubview:_mineView];
        
    }
    return self;
}

- (void)setMineViewModel:(MineCellViewModel *) mineViewModel
{
    _mineViewModel = mineViewModel;
    
    // 背景添加图片
    self.mineBackgroundView.frame = mineViewModel.mineBackgroundF;
    self.mineBackgroundView.image = [UIImage imageNamed:mineViewModel.mineModel.mineBackground];
    
    
    // 添加个人头像
    self.headerView.frame = mineViewModel.headerF;
    self.headerView.image = [UIImage imageNamed:mineViewModel.mineModel.header];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.headerView.bounds.size.width/6, self.headerView.bounds.size.height/6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.headerView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.headerView.layer.mask = maskLayer;

    //添加名字
    self.mineView.frame = mineViewModel.nameLabelF;
    self.mineView.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.mineView setBackgroundColor:[UIColor clearColor]];
    [self.mineView setTextColor:[UIColor whiteColor]];
    self.mineView.text = mineViewModel.mineModel.mineName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
