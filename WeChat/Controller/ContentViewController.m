//
//  ContentViewController.m
//  WeChat
//
//  Created by Chenning on 2021/5/12.
//

#import "ContentViewController.h"
#import "TopicModel.h"
#import "TopicCellViewModel.h"
#import "TopicTableViewCell.h"
#import "MineModel.h"
#import "MineCellViewModel.h"
#import "MineTableViewCell.h"
#include "CommentModel.h"

@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) MineModel *mineModel;
@property(nonatomic, copy) NSArray *dataSource;

@end

@implementation ContentViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"发现";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<TopicModel *> *listdata = [self _readDataFromLocal];
    //NSLog(@"");
    if (listdata) {
        for (int i = 0; i < listdata.count; i++) {
            TopicCellViewModel *viewModel = [[TopicCellViewModel alloc] init];
            viewModel.topicModel = listdata[i];
            [self.dataArray addObject:viewModel];
        }
    }else {
        TopicModel *topic = nil;
        [self setDataSource];
        int count = _dataSource.count;
        NSMutableArray *topicModels = [NSMutableArray array];
        
        NSArray *authors = [NSArray arrayWithObjects:@"鲁迅",@"老舍",@"冰心",@"巴金",@"胡适",nil];
        NSString *content = @"这种大茶馆现在已经不见了。在几十年前，每城都起码有一处。这里卖茶，也卖简单的点心与菜饭。玩鸟的人们，每天在蹓够了画眉、黄鸟等之后，要到这里歇歇腿，喝喝茶，并使鸟儿表演歌唱。";
        NSRange range = NSMakeRange(0, content.length);
        for (int i = 0; i < count; i++) {
            NSDictionary *dict = self.dataSource[i];
            topic = [[TopicModel alloc] init];
    //        topic.icon = [dict valueForKey:@"avatar"];
    //        topic.userName = [dict valueForKey:@"userName"];
    //        topic.content = [dict valueForKey:@"content"];
            
            int authorId = arc4random_uniform(authors.count);
            int commnentCount = arc4random_uniform(10);
            NSMutableArray *commentModels = [NSMutableArray array];
            
            CommentModel *commentModel = nil;
            for (int j = 0; j < commnentCount; j++) {
                commentModel = [[CommentModel alloc] init];
                
                commentModel.from = authors[authorId];
                if (j % 2 == 0) {
                    commentModel.to = topic.userName;
                }
                
                int index = arc4random_uniform(range.length);
                
                commentModel.content = [content substringFromIndex:index];
                [commentModels addObject:commentModel];
            }
            [topic configWithDictionary:dict :commentModels.copy];
            //topic.commentModels = commentModels.copy;
            [topicModels addObject:topic];
        }
        [self _archiveListDataWithArray:topicModels];
        
        for (int i = 0; i < topicModels.count; i++) {
            TopicCellViewModel *viewModel = [[TopicCellViewModel alloc] init];
            viewModel.topicModel = topicModels[i];
            [self.dataArray addObject:viewModel];
        }
    }
    
    MineModel *mineModel = [[MineModel alloc] init];
    mineModel.mineBackground = @"background.jpg";
    mineModel.header = @"header.jpg";
    mineModel.mineName = @"Ning";
    _mineModel = mineModel;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MineCellViewModel *mineViewModel = [[MineCellViewModel alloc] init];
        mineViewModel.mineModel = _mineModel;
        return mineViewModel.cellHeight;
    }else {
        TopicCellViewModel *topicViewModel = self.dataArray[indexPath.row - 1];
        return topicViewModel.cellHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
        if (!cell) {
            cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mine"];
        }
        MineCellViewModel *mineViewModel = [[MineCellViewModel alloc] init];
        mineViewModel.mineModel = _mineModel;
        [cell setMineViewModel:mineViewModel];
        return cell;
    }else {
        
        TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friends"];
        if (!cell) {
            cell = [[TopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"friends"];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull TopicTableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        [cell setTopicViewModel:self.dataArray[indexPath.row - 1]];
    }
}

- (NSArray<TopicModel *> *)_readDataFromLocal{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
 
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"TopicModelData/list"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[TopicModel class],[CommentModel class], nil]  fromData:readListData error:nil];
    
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<TopicModel *> *)unarchiveObj;
    }
    return nil;;
}


#pragma mark - private method

-(void)_archiveListDataWithArray:(NSArray<TopicModel *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"TopicModelData"];
    NSError *creatError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];
    
    //创建文件
    //NSData *data = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
}

-(void) setDataSource {
    if (!_dataSource) {
        //获取应用程序程序包中资源文件路径：
        NSString *path=[[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
        //通过路径获得json数据
        NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error = nil;
        //将json数据转换为OC对象数据
        _dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

@end
