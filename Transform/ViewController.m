//
//  ViewController.m
//  Transform
//
//  Created by macmini25 on 07/07/15.
//  Copyright (c) 2015 macmini25. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCustomView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showCustomView{
    CustomView *objCustomView = [[CustomView alloc]init];
    NSString *frame = [[NSUserDefaults standardUserDefaults]valueForKey:@"frame"];
    if (frame.length>0) {
        NSString *transform = [[NSUserDefaults standardUserDefaults]valueForKey:@"transform"];
        [objCustomView setFrame:CGRectFromString(frame)];
        [objCustomView setTransform:CGAffineTransformFromString(transform)];
        
    }else{
        [objCustomView setFrame:CGRectMake(0, 0, 80, 80)];
        [objCustomView setCenter:self.view.center];
    }
    [objCustomView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:objCustomView];
    [objCustomView setUpView];
}

@end
