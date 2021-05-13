//
//  TopicTableViewCell.h
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//
#import <UIKit/UIKit.h>
@class TopicCellViewModel;


NS_ASSUME_NONNULL_BEGIN

@interface TopicTableViewCell : UITableViewCell

@property(nonatomic, strong) TopicCellViewModel *topicViewModel;

@end

NS_ASSUME_NONNULL_END
