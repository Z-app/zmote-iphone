//
//  VFileHandlerViewController.m
//  TestApp
//
//  Created by Viktor Dahl on 2012-11-27.
//  Copyright (c) 2012 Viktor Dahl. All rights reserved.
//

#import "ZFileHandlerViewController.h"

@interface ZFileHandlerViewController ()

@end

@implementation ZFileHandlerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
        
        /* Label */
        CGRect labelFrame = CGRectMake( 0, 0, 150, 30 );
        UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
        [label setText: @"FileHandlerView"];
        [label setTextColor: [UIColor whiteColor]];
        [label setBackgroundColor: [UIColor clearColor]];
        [self.view addSubview: label];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)iconImageName {
	return @"5_sd_card_s.png" ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

@end


