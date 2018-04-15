//
//  AppDelegate.m
//  appmall
//
//  Created by majun on 2018/4/14.
//  Copyright © 2018年 com.tcsw.tkzy. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()<NewFeatureViewDelegate>
{
    NSUserDefaults *defaults;
    UITabBarController *tabBarControllerMain;
    NSString * lastVersion;//应用内保存的版本号
    NSString * curVersion; //当前版本号
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    defaults = [NSUserDefaults standardUserDefaults];
    [self loadTabVC];
    [self setKeyWindow ];
    [self setNewFeature];
    return YES;
}

-(void)showNewFeature{
    NewFeatureViewController * newFeatureVC = [[NewFeatureViewController alloc]init];
    newFeatureVC.delegate = self;
    _window.rootViewController = newFeatureVC;
    
}
-(void)setNewFeature{
    
    lastVersion = [defaults objectForKey:KEYAPPVERSION];
    curVersion = [NSBundle mainBundle].infoDictionary[KEYCURAPPVERSION];
    if ([curVersion isEqualToString:lastVersion]) { //
     
        _window.rootViewController = tabBarControllerMain;
    }else{
        [defaults setObject:curVersion forKey:KEYAPPVERSION];
        [defaults synchronize];
        [self showNewFeature];
    }
}

-(void)setKeyWindow{
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor whiteColor];
    
}

- (void) loadTabVC {
    
    NSMutableDictionary *tabAttrs = [NSMutableDictionary dictionaryWithCapacity: 5];
    tabAttrs[@"tabTitle"] = @"首页";
    tabAttrs[@"title"] = @"首页";
    tabAttrs[@"itemNormal"] = @"首页-未选中";
    tabAttrs[@"itemSelected"] = @"首页";
    tabAttrs[@"rootVC"] = @"HomeViewController";
    UINavigationController *homeNavVC = [self tabNavVCWithAttr: tabAttrs];
    tabAttrs[@"title"] = @"天康学院";
    tabAttrs[@"tabTitle"] = @"天康学院";
    tabAttrs[@"itemNormal"] = @"天康学院-未选中";
    tabAttrs[@"itemSelected"] = @"天康学院";
    tabAttrs[@"rootVC"] = @"CollegeViewController";
    UINavigationController *collegeNavVC = [self tabNavVCWithAttr: tabAttrs];
    
    tabAttrs[@"tabTitle"] = @"社区";
    tabAttrs[@"title"] = @"社区";
    tabAttrs[@"itemNormal"] = @"社区-未选中";
    tabAttrs[@"itemSelected"] = @"社区";
    tabAttrs[@"rootVC"] = @"CommunityViewController";
    UINavigationController *communityNavVC = [self tabNavVCWithAttr: tabAttrs];
    
    
    tabAttrs[@"tabTitle"] = @"购物车";
    tabAttrs[@"title"] = @"购物车";
    tabAttrs[@"itemNormal"] = @"购物车-未选中";
    tabAttrs[@"itemSelected"] = @"购物车";
    tabAttrs[@"rootVC"] = @"ShoppingCartViewController";
    UINavigationController *shoppingNavVC = [self tabNavVCWithAttr: tabAttrs];
    
    tabAttrs[@"tabTitle"] = @"我的";
    tabAttrs[@"title"] = @"我的";
    tabAttrs[@"itemNormal"] = @"我-未选中";
    tabAttrs[@"itemSelected"] = @"我";
    tabAttrs[@"rootVC"] = @"MineViewController";
    UINavigationController *mineNavVC = [self tabNavVCWithAttr: tabAttrs];
    
    tabBarControllerMain = [[UITabBarController alloc] init];
    tabBarControllerMain.viewControllers = @[homeNavVC,collegeNavVC,communityNavVC, shoppingNavVC,mineNavVC];
    tabBarControllerMain.view.frame = CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height);
    
    
    tabBarControllerMain.tabBar.backgroundColor =   RGBCOLOR(245, 245, 245);;
    tabBarControllerMain.tabBar.barTintColor =   RGBCOLOR(245, 245, 245);
}


- (UINavigationController *) tabNavVCWithAttr: (NSDictionary*) attrs {
    UIImage *normalImage = [[UIImage imageNamed: attrs[@"itemNormal"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed: attrs[@"itemSelected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle: attrs[@"tabTitle"] image: normalImage selectedImage: selectedImage];
    NSDictionary *normalAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor grayColor]};
    [tabBarItem setTitleTextAttributes: normalAttributes forState:UIControlStateNormal];
    
    NSDictionary *selectedAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor redColor]};
    [tabBarItem setTitleTextAttributes: selectedAttributes forState:UIControlStateSelected];
    NSString *rootVCClassName = attrs[@"rootVC"];
    
    UIViewController *rootVC = [[NSClassFromString(rootVCClassName) alloc] initWithNibName: rootVCClassName bundle: nil];
    
    rootVC.title = attrs[@"title"];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
    navVC.navigationBar.barTintColor = RGBCOLOR(245, 245, 245);
    
    navVC.tabBarItem = tabBarItem;
    
    
    navVC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    navVC.navigationBar.tintColor = [UIColor whiteColor];
    return navVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)newFeatureSetRootVC{
    _window.rootViewController = tabBarControllerMain;
    
}

@end
