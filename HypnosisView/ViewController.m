//
//  ViewController.m
//  HypnosisView
//
//  Created by test on 12/21/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

#import "ViewController.h"
#import "BNRHypnosisView.h"

@interface ViewController ()
@property (nonatomic) BNRHypnosisView *hypnosisView1;
@property (nonatomic) BNRHypnosisView *hypnosisView2;
@end

@implementation ViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"我晕";
        UIImage *image = [UIImage imageNamed:@"Hypno"];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect screenRect = self.view.bounds;
    
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
//    bigRect.size.height *= 2.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [scrollView setPagingEnabled:YES];
    [self.view addSubview:scrollView];
    
    
    self.hypnosisView1 = [[BNRHypnosisView alloc] initWithFrame:screenRect];
   
    CGRect segmentRect = CGRectMake((screenRect.size.width / 2.0) - 75, 50, 150, 30);
    NSArray* items = @[@"红",@"绿",@"蓝"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.frame = segmentRect;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    [self.hypnosisView1 addSubview:segmentedControl];
    [segmentedControl addTarget:self action:@selector(segmentedControlDidTapped:) forControlEvents:UIControlEventValueChanged];
    
    CGRect textRect = CGRectMake((screenRect.size.width / 2.0) - 120, 90, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textRect];
    [textField setPlaceholder:@"催眠我"];
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [self.hypnosisView1 addSubview:textField];
    
    UIScrollView * hypnosisView1Wapped = [[UIScrollView alloc] init]; //在hypnosisView1外再包一层UIScrollView
    hypnosisView1Wapped.frame = screenRect;
    [hypnosisView1Wapped addSubview:self.hypnosisView1];
    hypnosisView1Wapped.delegate = self;
    hypnosisView1Wapped.minimumZoomScale = 1.0;
    hypnosisView1Wapped.maximumZoomScale = 2.0;
    hypnosisView1Wapped.tag = 1023;
    
    [scrollView addSubview:hypnosisView1Wapped];

    _hypnosisView2 = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    screenRect.origin.x += screenRect.size.width;

    UIScrollView * hypnosisView1Wapped2 = [[UIScrollView alloc] init]; //在hypnosisView2外再包一层UIScrollView
    hypnosisView1Wapped2.frame = screenRect;
    [hypnosisView1Wapped2 addSubview:_hypnosisView2];
    hypnosisView1Wapped2.delegate = self;
    hypnosisView1Wapped2.minimumZoomScale = 1.0;
    hypnosisView1Wapped2.maximumZoomScale = 2.0;
    hypnosisView1Wapped2.tag = 1024;

    [scrollView addSubview:hypnosisView1Wapped2];

    scrollView.contentSize = bigRect.size;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedControlDidTapped:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.hypnosisView1.circleColor = [UIColor redColor];
    }
    else if (sender.selectedSegmentIndex == 1){
        self.hypnosisView1.circleColor = [UIColor greenColor];
    }
    else if (sender.selectedSegmentIndex == 2){
        self.hypnosisView1.circleColor = [UIColor blueColor];
    }
    [self.hypnosisView1 setNeedsDisplay];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessages:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

-(void)drawHypnoticMessages:(NSString *) msg
{
    for (int i = 0; i < 20; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 200, MAXFLOAT)];
        label.textColor = [UIColor blackColor];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.text = msg;
        [label sizeToFit];
        
        int width = (self.view.bounds.size.width - label.bounds.size.width);
        NSLog(@"self width:%f label width:%f",self.view.bounds.size.width,label.bounds.size.width);
        int x = arc4random() % (width);
        
        int height = (self.view.bounds.size.height - label.bounds.size.height);
        int y = arc4random() % (int)(self.view.bounds.size.height);
        
        CGRect frame = label.frame;
        frame.origin = CGPointMake(x, y);
        label.frame = frame;
        [self.hypnosisView1 addSubview:label];
        
        UIInterpolatingMotionEffect *effct;
        effct = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        effct.minimumRelativeValue = @(-25);
        effct.maximumRelativeValue = @(25);
        [label addMotionEffect:effct];
        
        effct = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        effct.minimumRelativeValue = @(-25);
        effct.maximumRelativeValue = @(25);
        [label addMotionEffect:effct];
    }
} //drawHypnoticMessages

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1023) {
        return self.hypnosisView1;
    }
    else {
        return _hypnosisView2;
    }
}//viewForZoomingInScrollView
@end
