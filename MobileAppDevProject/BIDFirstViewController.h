//
//  BIDFirstViewController.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface BIDFirstViewController : UIViewController {
    sqlite3 *contactDB;
    UITextField *taskName;
    UITextField *posterName;
    UITextField *descField;
    UILabel *staus;
    NSString *databasePath;
    
    IBOutlet UIScrollView *scView;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scView;
@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UITextField *posterName;
//Use below for the description text field
@property (strong, nonatomic) IBOutlet UITextField *descField;
@property (strong, nonatomic) IBOutlet UITextView *largeDescField;
@property (strong, nonatomic) IBOutlet UILabel *status;

- (IBAction)savePost:(id)sender;

-(IBAction) hideKeyboard:(id)sender;

@end
