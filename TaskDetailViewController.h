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
@property (strong, nonatomic) IBOutlet UILabel *recID;
@property (strong, nonatomic) IBOutlet UILabel *recordDesc;
@property (strong, nonatomic) IBOutlet UILabel *posterName;
@property (strong, nonatomic) IBOutlet UILabel *dateDue;
@property (strong, nonatomic) IBOutlet UILabel *datePosted;

@property BOOL isTaken;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *recordID;
@property (strong, nonatomic) NSString *thePosterName;
@property (strong, nonatomic) NSString *theDateDue;
@property (strong, nonatomic) NSString *theDatePosted;
@property (strong, nonatomic) NSString *description;

- (IBAction)takeTask:(id)sender;

@end
