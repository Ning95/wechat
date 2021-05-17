//
//  CommentTableViewCell.m
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import "CommentTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "CommentModel.h";
#import "CommentViewModel.h";

@interface CommentTableViewCell()
@property(nonatomic, strong) UILabel *commentView;
@end

@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _commentView = [[UILabel alloc] init];
        [self.contentView addSubview:_commentView];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setCommentViewModel:(CommentViewModel *)commentViewModel
{
    _commentViewModel = commentViewModel;
    
    self.commentView.frame = commentViewModel.contentLabelF;
    self.commentView.text = commentViewModel.contentString;
    self.commentView.lineBreakMode = NSLineBreakByWordWrapping;
    self.commentView.numberOfLines = 0;;
    self.commentView.backgroundColor = [UIColor clearColor];
    self.commentView.font = [UIFont systemFontOfSize:12.0];
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
