//
//  CommentViewModel.h
//  WeChat
//
//  Created by Chenning on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CommentModel;
NS_ASSUME_NONNULL_BEGIN

@interface CommentViewModel : NSObject

@property(nonatomic, assign) CGFloat maxW;
@property(nonatomic, strong) CommentModel *commentModel;
@property(nonatomic, copy) NSString *contentString;
@property(nonatomic, assign) CGRect  contentLabelF;
@property(nonatomic, assign) float cellHeight;

@end

NS_ASSUME_NONNULL_END
