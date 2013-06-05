//
//  MyTasksNavViewController.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 6/5/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MyTasksNavViewController : UITableViewController{
    sqlite3 *contactDB;
    NSString *databasePath;
    
}

@property (strong, nonatomic) NSMutableArray *theControllers;

@end
