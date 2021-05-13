//
//  MineTableViewCell.h
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import <UIKit/UIKit.h>


@class MineCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : UITableViewCell

@property(nonatomic, strong) MineCellViewModel *mineViewModel;

@end

NS_ASSUME_NONNULL_END
