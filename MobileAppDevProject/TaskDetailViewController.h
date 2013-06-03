//
//  TaskDetailViewController.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/29/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TaskDetailViewController : UIViewController{
    sqlite3 *contactDB;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UILabel *theLabel;
@property (strong, nonatomic) NSString *message;

@end
