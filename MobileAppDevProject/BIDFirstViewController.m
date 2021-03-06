//
//  BIDFirstViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "BIDFirstViewController.h"
#import <QuartzCore/QuartzCore.h>


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
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"TaskTaker.db"]];
            
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath: databasePath] == NO){
        const char *dbPath = [databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &contactDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS TASKS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, POSTERNAME TEXT, DESCRIPTION TEXT, DATEPOSTED DATETIME, DATEDUE TEXT, ISTAKEN INTEGER DEFAULT 0)";
            
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
    [scView setContentSize:CGSizeMake(320, 800)];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [scView addGestureRecognizer:tapScroll];
    
    //Set UITextView border and shading
    [[self.descField layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.descField layer] setBorderWidth:2.3];
    [[self.descField layer] setCornerRadius:15];
     
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
    //Get date from date picker
    NSDate *date = [self.datePicker date];
    
    
    //find the DB and insert into
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (self.taskName.text.length < 1 || self.descField.text.length < 1 || self.posterName.text.length < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Valid Values" message:@"Please enter values into the text fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *insertSQL = ([NSString stringWithFormat:@"INSERT INTO TASKS (name, postername, description, dateposted, datedue) VALUES (\"%@\",\"%@\",\"%@\",DATETIME('now'),\"%@\")",taskName.text, posterName.text, descField.text,date]);
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE){
                status.text = @"Task Added";
                //Clear the values here
                self.taskName.text = @"";
                self.posterName.text = @"";
                self.descField.text = @"";
            } else {
                status.text = @"Failed to add task";
                NSLog(@"SQLITE ERROR: %s", sqlite3_errmsg(contactDB));
            }
            sqlite3_finalize(statement);
            sqlite3_close(contactDB);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Task Added" message:@"This task has been saved and added to 'All Tasks'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        } else {
            NSLog(@"Error Opening Database");
        }
    }
}

- (IBAction)hideKeyboard:(id)sender{
    [taskName resignFirstResponder];
    [descField resignFirstResponder];
    
}

@end






