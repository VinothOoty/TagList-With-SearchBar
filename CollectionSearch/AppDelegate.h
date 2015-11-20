//
//  AppDelegate.h
//  CollectionSearch
//
//  Created by SYZYGY01 on 19/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HomeViewController *homeObj;
    UINavigationController *naviObj;
}
@property (strong, nonatomic) UIWindow *window;

@end
