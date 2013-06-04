//
//  BIDFirstViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "BIDFirstViewController.h"

@interface BIDFirstViewController ()

@end

@implementation BIDFirstViewController

@synthesize scView,taskName, posterName, descField, status;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Post Task", @"Post Task");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Getting Documents directory for project
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build path to DB file "tasks.db"
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"tasks.db"]];
            
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath: databasePath] == NO){
        const char *dbPath = [databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &contactDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS TASKS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, POSTERNAME TEXT, DESCRIPTION TEXT, DATEPOSTED DATETIME, DATEDUE DATETIME)";
            
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                status.text = @"Failed to create table";
            }
            sqlite3_close(contactDB);
        } else {
            status.text = @"Failed to open/create database";
        }
    }
    status.text = @"Finished Loading viewDidLoad";
    
    
    [scView setScrollEnabled:YES];
    [scView setContentSize:CGSizeMake(320, 900)];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [scView addGestureRecognizer:tapScroll];
     
    [super viewDidLoad];

}

- (void) tapped {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidUnload {
    self.taskName = nil;
    self.posterName = nil;
    self.descField = nil;
    self.status = nil;
}
/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [taskName resignFirstResponder];
}*/


- (IBAction)savePost:(id)sender {
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *insertSQL = ([NSString stringWithFormat:@"INSERT INTO TASKS (name, postername, description, dateposted, datedue) VALUES (\"%@\",\"NPants\",\"%@\",DATETIME('now'),DATETIME('now'))",taskName.text, descField.text]);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            status.text = @"Task Added";
            //Clear the values here
        } else {
            status.text = @"Failed to add task";
            NSLog(@"SQLITE ERROR: %s", sqlite3_errmsg(contactDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

- (IBAction)hideKeyboard:(id)sender{
    [taskName resignFirstResponder];
    [descField resignFirstResponder];
    
}

@end






