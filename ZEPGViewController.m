//
//  VEPGViewController.m
//  TestApp
//
//  Created by Viktor Dahl on 2012-11-26.
//  Copyright (c) 2012 Viktor Dahl. All rights reserved.
//

#import "ZEPGViewController.h"
@interface ZEPGViewController ()

@end

@implementation ZEPGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
        
        /* Label */
        CGRect labelFrame = CGRectMake( 0, 0, 100, 30 );
        UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
        [label setText: @"EPGView"];
        [label setTextColor: [UIColor whiteColor]];
        [label setBackgroundColor: [UIColor clearColor]];
        [self.view addSubview: label];
        
        /* The top bar, above tabbed bar */
        UIView* topFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        topFrame.backgroundColor = [UIColor blackColor];
        [self.view addSubview: topFrame];
        
        NSInteger topLineThickness = 2;
        UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0,topFrame.frame.size.height - topLineThickness, topFrame.frame.size.width, topLineThickness)];
        topLine.backgroundColor = RGBCOLOR(48, 180, 224);
        [topFrame addSubview:topLine];

        
         
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

// New shit

- (NSString *)iconImageName {
	return @"3_epg_s.png" ;
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
