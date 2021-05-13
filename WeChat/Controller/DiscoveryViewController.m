//
//  DiscoveryViewController.m
//  WeChat
//
//  Created by Chenning on 2021/5/8.
//

#import "DiscoveryViewController.h"
#import "Friend.h"
#import "TTTAttributedLabel.h"

@interface DiscoveryViewController () <UITableViewDataSource,UITableViewDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property(nonatomic, copy) NSArray *dataSource;

@end

@implementation DiscoveryViewController

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
	// Do any additional setup after loading the view.
	UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
	tableView.dataSource = self;
	tableView.delegate = self;
	[self.view addSubview:tableView];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *controller = [[UIViewController alloc] init];
//    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//    controller.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:controller animated:YES];
//}

-(NSArray *)dataSource {
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
	return _dataSource;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 300;
    }else {
        NSDictionary *dict = self.dataSource[indexPath.row - 1];
        unsigned long length = [[dict valueForKey: @"content"] length];
        long height = 0;
        height = (length % 20 == 0) ? (length/ 20) * 10 : (length / 20  + 1) * 10;
        return height + 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
	}
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240)];
        imageView.image = [UIImage imageNamed:@"background.jpg"];
        
        UIImageView *imageHeader = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width- 60, 220, 60, 60)];
        imageHeader.image = [UIImage imageNamed:@"header.jpg"];
        
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:imageHeader];
    }else {
        NSDictionary *dict = self.dataSource[indexPath.row - 1];

        //头像设置
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"avatar"]]];
        // 添加图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        imageView.image = [UIImage imageWithData:imageData];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(imageView.bounds.size.width/6, imageView.bounds.size.height/6)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = imageView.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        imageView.layer.mask = maskLayer;
        
        // 添加双击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginWobble:)];
        tapGesture.numberOfTapsRequired = 2;
        [imageView addGestureRecognizer:tapGesture];
        //注意：UIImageView的userInteractionEnabled属性默认是NO
        imageView.userInteractionEnabled = YES;
        
        [cell.contentView addSubview:imageView];

        //姓名
        UITextView *textUserName= [[UITextView alloc] initWithFrame:CGRectMake(cell.frame.origin.x  + 20 + imageView.frame.size.width, cell.frame.origin.y + 10, 80, 26)];
        textUserName.text = nil;
        textUserName.font = [UIFont fontWithName:@"Arial" size:18.0];
        textUserName.text = [dict valueForKey:@"userName"];

        [cell.contentView addSubview:textUserName];
        //NSLog(@"%ld",[[dict valueForKey: @"content"] length]);

        //朋友圈内容
        CGFloat contentLabelH = 0;
        NSString *content = nil;
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * 10;
        CGFloat contentLabelW = contentW - imageView.frame.size.width - 10;
        content = [dict valueForKey: @"content"];
        UIFont *contentLabelFont = [UIFont systemFontOfSize:14.0];
        contentLabelH = [content boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentLabelFont} context:nil].size.height;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(cell.frame.origin.x +20 + imageView.frame.size.width, cell.frame.origin.y + 20 + textUserName.frame.size.height, contentLabelW, contentLabelH)];
        textView.text = nil;
        textView.font = [UIFont fontWithName:@"Arial" size:14.0];
        textView.text = content;

        [cell.contentView addSubview:textView];
        //cell.detailTextLabel.text = [dict valueForKey: @"content"];
    }
	return cell;
}

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
@end
