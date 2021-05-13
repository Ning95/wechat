//
//  TopicCellViewModel.h
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TopicModel;

NS_ASSUME_NONNULL_BEGIN

@interface TopicCellViewModel : NSObject

@property(nonatomic, strong) TopicModel *topicModel;
@property(nonatomic, strong) NSArray *commentCellViewModels;
@property(nonatomic, assign) CGRect iconF;
@property(nonatomic, assign) CGRect nameLabelF;
@property(nonatomic, assign) CGRect contentF;
@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, assign) CGRect tableviewF;

@end

NS_ASSUME_NONNULL_END
