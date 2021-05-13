//
//  MineCellViewModel.h
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MineModel;
NS_ASSUME_NONNULL_BEGIN

@interface MineCellViewModel : NSObject

@property(nonatomic, strong) MineModel *mineModel;
@property(nonatomic, assign) CGRect mineBackgroundF;
@property(nonatomic, assign) CGRect nameLabelF;
@property(nonatomic, assign) CGRect headerF;
@property(nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
