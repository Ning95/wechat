//
//  CommentTableViewCell.h
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CommentViewModel, CommentTableViewCell;

@protocol CommentTableViewCellDelegate <NSObject>

- (void)cell:(CommentTableViewCell *)cell didUserInfoClicked:(NSString *)username;

@end

@interface CommentTableViewCell : UITableViewCell

@property(nonatomic, strong) CommentViewModel *commentViewModel;
@property(nonatomic, weak) id<CommentTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
