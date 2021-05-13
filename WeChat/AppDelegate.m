//
//  AppDelegate.m
//  WeChat
//
//  Created by Chenning on 2021/5/8.
//

#import "AppDelegate.h"
#import "DiscoveryViewController.h"
#import "ContentViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *chatController = [[UIViewController alloc]init];
    chatController.tabBarItem.title = @"微信";
    
    UIViewController *buddyController = [[UIViewController alloc]init];
    buddyController.tabBarItem.title = @"联系人";
    
    ContentViewController *discoveryController = [[ContentViewController alloc]init];
    
    UIViewController *myController = [[UIViewController alloc]init];
    myController.tabBarItem.title = @"我";
    
    [tabBarController setViewControllers:@[chatController,buddyController,discoveryController,myController]];
    tabBarController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    self.window.rootViewController = navigationController;
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
