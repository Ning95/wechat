# iOS 微信开发
## ⭐️ 概述 
- 工程主要是利用MVVM的方式来搭建微信，主要实现了朋友圈的模块
- 本工程完全采用Objective-C语言编写
## 🚀 功能解析
- json数据的加载
```
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
```
> 注意这里解析出来的dataSource是一个字典数组

- 双击图片抖动
```
// 添加双击手势
UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginWobble:)];
tapGesture.numberOfTapsRequired = 2;
[self.icon addGestureRecognizer:tapGesture];
//注意：UIImageView的userInteractionEnabled属性默认是NO
self.icon.userInteractionEnabled = YES;

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
```
- 头像使用圆角展示
```
//头像设置
NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topicViewModel.topicModel.icon]];
// 添加图片
self.icon.frame = topicViewModel.iconF;
self.icon.image = [UIImage imageWithData:imageData];
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.icon.bounds.size.width/6, self.icon.bounds.size.height/6)];
CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//设置大小
maskLayer.frame = self.icon.bounds;
//设置图形样子
maskLayer.path = maskPath.CGPath;
self.icon.layer.mask = maskLayer;
```





