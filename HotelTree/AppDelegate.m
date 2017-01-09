//
//  AppDelegate.m
//  HotelTree
//
//  Created by Lucas Luo on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "AppDelegate.h"
#import "PayPalMobile.h"
#import <CoreLocation/CoreLocation.h>
#import "ModelManager.h"

static NSString *client_id = @"ATRCTb8tL2oIqDtUKQy0hNU7HD23I3GkxPcMhaJXY6CPYH_uqUKaPWrVftzzccHkd7POK9o7iKzXDmPT";
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox:client_id}];
    return YES;
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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [userDefault objectForKey:@"userID"];
    if(mobile){
        [[ModelManager sharedInstance] removeUser:mobile];
    }
}


@end
