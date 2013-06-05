//
//  BIDAppDelegate.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationController *navBarController;

@property (strong, nonatomic) UINavigationController *myTaskNavController;

@end
