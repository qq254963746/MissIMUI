//
//  AppDelegate.m
//  MissIMDemo
//
//  Created by xiangwenwen on 15/4/4.
//  Copyright (c) 2015年 xiangwenwen. All rights reserved.
//

#import "AppDelegate.h"


#import <AVOSCloud/AVOSCloud.h>

#define LEANCLOUD_APP_ID "k7l1owizpqx0ec7ttc6wwb6gkddl8ibbp68kklv3gepokm9k"
#define LEANCLOUD_APP_KEY "7u0ji58i7w510gv65jw2qzatasuupx5ccqqsssfhs2rqaj83"

@interface AppDelegate ()

@property(nonatomic,strong)NSMutableArray *dataMessage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AVOSCloud setApplicationId:@LEANCLOUD_APP_ID clientKey:@LEANCLOUD_APP_KEY];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMissIMPlistFile:) name:@"saveMissIMPlist" object:nil];
    self.dataMessage = [[NSMutableArray alloc] init];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //非活动状态下执行
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //当应用程序退出时调用
    if (self.dataMessage.count) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:self.dataMessage[0]];
        NSString *MissIMPlistPath = data[@"MissIMPlistPath"];
        [data removeObjectForKey:@"MissIMPlistPath"];
        NSFileManager *manager = [[NSFileManager alloc] init];
        BOOL isMissIM = [manager fileExistsAtPath:MissIMPlistPath];
        if (!isMissIM) {
            [manager createFileAtPath:MissIMPlistPath contents:nil attributes:nil];
        }
        [data writeToFile:MissIMPlistPath atomically:YES];
    }
    NSLog(@"----close");
}

- (void)saveMissIMPlistFile:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    if (self.dataMessage.count) {
        [self.dataMessage removeAllObjects];
    }
    [self.dataMessage addObject:info];
}

@end
