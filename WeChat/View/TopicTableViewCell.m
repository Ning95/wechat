//
//  TopicTableViewCell.m
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import "TopicTableViewCell.h"
#import "TopicCellViewModel.h"
#import "TopicModel.h"
#import "CommentViewModel.h"
#import "CommentTableViewCell.h"

@interface TopicTableViewCell()<UITableViewDelegate, UITableViewDataSource>
    @property(nonatomic, strong) UIImageView *icon;
    @property(nonatomic, strong) UILabel *nameView;
    @property(nonatomic, strong) UILabel *contentTopicView;
    @property(nonatomic, strong) UITableView *commentTableView;
@end


@implementation TopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        
        _nameView = [[UILabel alloc] init];
        [self.contentView addSubview:_nameView];
        
        _contentTopicView = [[UILabel alloc] init];
        [self.contentView addSubview:_contentTopicView];
        
        
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.backgroundColor = [UIColor colorWithRed:236/256.0 green:236/256.0 blue:236/256.0 alpha:1];
        _commentTableView.bounces = NO;
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_commentTableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"comment"];
        [self.contentView addSubview:_commentTableView];
    }
    return self;
}


- (void)setTopicViewModel:(TopicCellViewModel *)topicViewModel
{
    _topicViewModel = topicViewModel;
//    NSThread *downLoadImageThread = [[NSThread alloc] initWithBlock:^{
//
//    }];
//    downLoadImageThread.name = @"downLoadImageThread";
//    [downLoadImageThread start];
    
    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
    dispatch_async(downloadQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topicViewModel.topicModel.icon]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(mainQueue, ^{
            self.icon.frame = topicViewModel.iconF;
            self.icon.image = image;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.icon.bounds.size.width/6, self.icon.bounds.size.height/6)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            //设置大小
            maskLayer.frame = self.icon.bounds;
            //设置图形样子
            maskLayer.path = maskPath.CGPath;
            self.icon.layer.mask = maskLayer;
        });
    });
    //头像设置
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topicViewModel.topicModel.icon]];
    // 添加图片
//    self.icon.frame = topicViewModel.iconF;
//    self.icon.image = [UIImage imageWithData:imageData];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.icon.bounds.size.width/6, self.icon.bounds.size.height/6)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//        //设置大小
//        maskLayer.frame = self.icon.bounds;
//        //设置图形样子
//        maskLayer.path = maskPath.CGPath;
//        self.icon.layer.mask = maskLayer;
    
    
    // 添加双击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginWobble:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.icon addGestureRecognizer:tapGesture];
    //注意：UIImageView的userInteractionEnabled属性默认是NO
    self.icon.userInteractionEnabled = YES;
    
    
    self.nameView.frame = topicViewModel.nameLabelF;
    self.nameView.font = [UIFont fontWithName:@"Arial" size:18.0];
    self.nameView.text = topicViewModel.topicModel.userName;
    
    
    self.contentTopicView.frame = topicViewModel.contentF;
    self.contentTopicView.font = [UIFont systemFontOfSize:14.0];
    self.contentTopicView.text = topicViewModel.topicModel.content;
    // 自动折行设置
    // 为了使标签文本适合其边界矩形而使用的最大行数。此属性的默认值为1。
    // 要删除任何最大限​​制，并根据需要使用尽可能多的行，请将此属性的值设置为0。
    self.contentTopicView.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentTopicView.numberOfLines = 0;
    
    
    self.commentTableView.frame = topicViewModel.tableviewF;
    [self.commentTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CommentViewModel *topicViewModel = self.topicViewModel.commentCellViewModels[indexPath.row];
    
    //NSLog(@"");
    return topicViewModel.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topicViewModel.commentCellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    cell.commentViewModel = self.topicViewModel.commentCellViewModels[indexPath.row];
    return cell;
}

//实现头像抖动功能
-(void)beginWobble:(UITapGestureRecognizer *)tapGestureRecognizer{
     CALayer *viewLayer = tapGestureRecognizer.view.layer;
     CGPoint position = viewLayer.position;
     CGPoint x = CGPointMake(position.x + 1, position.y);
     CGPoint y = CGPointMake(position.x - 1, position.y);
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
     [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
     [animation setFromValue:[NSValue valueWithCGPoint:x]];
     [animation setToValue:[NSValue valueWithCGPoint:y]];
     [animation setAutoreverses:YES];
     [animation setDuration:.06];
     [animation setRepeatCount:5];
     [viewLayer addAnimation:animation forKey:nil];
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
