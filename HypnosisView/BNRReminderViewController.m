//
//  BNRReminderViewController.m
//  HypnosisView
//
//  Created by test on 12/22/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"提醒";
        UIImage *image = [UIImage imageNamed:@"Time"];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60];
    self.datePicker.minimumDate = date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Date:%@",date);

//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    double inteval = [zone secondsFromGMTForDate:date];
//    NSDate *localDate = [date dateByAddingTimeInterval:inteval];
//    
//    NSLog(@"localDate:%@",localDate);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    //note.timeZone = [NSTimeZone systemTimeZone];
    note.alertBody = @"时间到！！";
    note.fireDate = date;

    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
