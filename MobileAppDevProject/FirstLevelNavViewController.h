//
//  FirstLevelNavViewController.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/28/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FirstLevelNavViewController : UITableViewController{
    sqlite3 *contactDB;
    NSString *databasePath;
}

@property (strong, nonatomic) NSArray *controllers;
@property (strong, nonatomic) NSMutableArray *theControllers;
@property (strong, nonatomic) NSMutableDictionary *theCont;

@end
