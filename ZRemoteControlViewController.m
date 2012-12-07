//
//  VRemoteControlViewController.m
//  TestApp
//
//  Created by Viktor Dahl on 2012-11-26.
//  Copyright (c) 2012 Viktor Dahl. All rights reserved.
//

#import "ZRemoteControlViewController.h"
#import <UIKit/UIKit.h>

@class VRemoteControlImpl;
@class UISlider;

@interface ZRemoteControlViewController ()

@end

@implementation ZRemoteControlViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    remoteControl = [[VRemoteControlImpl alloc] init];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /* Background color */
        self.view.backgroundColor = [UIColor blackColor];
        channelViewLoaded = false;
    }
    return self;
}

// Test function. Not used
-(void) setActiveChannel {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* The offset for the navigation pad, i.e. it's position in x and y coordinates. */
    int offsetAll = 85;
    int navigationOffsetX = 69;
    int navigationOffsetY = 88 + offsetAll;
    
    /* Label */
    CGRect labelFrame = CGRectMake( 0, 0, 180, 30 );
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setText: @"RemoteControlView"];
    [label setTextColor: [UIColor whiteColor]];
    [label setBackgroundColor: [UIColor clearColor]];
    //        [self.view addSubview: label]; //Dont show it
    
    /* Up button */
    CGRect upButtonFrame = CGRectMake( 64 + navigationOffsetX, 0 + navigationOffsetY, 54, 80 ); // 64 standard
    UIButton *upButton = [[UIButton alloc] initWithFrame: upButtonFrame];
    [upButton addTarget: remoteControl     /* ClickListener */
                 action: @selector(executeCommand:)
       forControlEvents: UIControlEventTouchDown];
    [upButton setImage:[UIImage imageNamed:@"pad_normal_small.png"] forState: UIControlStateNormal];
    [upButton setImage:[UIImage imageNamed:@"pad_pressed_small"] forState: UIControlStateHighlighted];
    upButton.tag = 100;
    [self.view addSubview: upButton];
    
    /* Down button */
    CGRect downButtonFrame = CGRectMake( 65 + navigationOffsetX, 127 + navigationOffsetY, 54, 80 );
    UIButton *downButton = [[UIButton alloc] initWithFrame: downButtonFrame];
    [downButton addTarget: remoteControl     /* ClickListener*/
                   action: @selector(executeCommand:)
         forControlEvents: UIControlEventTouchDown];
    [downButton setImage:[UIImage imageNamed:@"pad_normal_small.png"] forState: UIControlStateNormal];
    [downButton setImage:[UIImage imageNamed:@"pad_pressed_small"] forState: UIControlStateHighlighted];
    downButton.transform = CGAffineTransformMakeRotation(180.0*M_PI/180.0);
    downButton.tag = 101;
    [self.view addSubview: downButton];
    
    /* Left button */
    CGRect leftButtonFrame = CGRectMake( 0 + navigationOffsetX, 64 + navigationOffsetY, 54, 80 );
    UIButton *leftButton = [[UIButton alloc] initWithFrame: leftButtonFrame];
    [leftButton addTarget: remoteControl     /* ClickListener*/
                   action: @selector(executeCommand:)
         forControlEvents: UIControlEventTouchDown];
    [leftButton setImage:[UIImage imageNamed:@"pad_normal_small.png"] forState: UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"pad_pressed_small"] forState: UIControlStateHighlighted];
    leftButton.transform = CGAffineTransformMakeRotation(270.0*M_PI/180.0);
    leftButton.tag = 102;
    [self.view addSubview: leftButton];
    
    /* Right button */
    CGRect rightButtonFrame = CGRectMake( 129 + navigationOffsetX, 63 + navigationOffsetY, 54, 80 );
    UIButton *rightButton = [[UIButton alloc] initWithFrame: rightButtonFrame];
    [rightButton addTarget: remoteControl     /* ClickListener*/
                    action: @selector(executeCommand:)
          forControlEvents: UIControlEventTouchDown];
    [rightButton setImage:[UIImage imageNamed:@"pad_normal_small.png"] forState: UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"pad_pressed_small"] forState: UIControlStateHighlighted];
    rightButton.transform = CGAffineTransformMakeRotation(90.0*M_PI/180.0);
    rightButton.tag = 103;
    [self.view addSubview: rightButton];
    
    /* Mid button */
    CGRect midButtonFrame = CGRectMake( 64 + navigationOffsetX, 76 + navigationOffsetY, 54, 54 ); // 67 standard
    UIButton *midButton = [[UIButton alloc] initWithFrame: midButtonFrame];
    [midButton addTarget: remoteControl     /* ClickListener*/
                  action: @selector(executeCommand:)
        forControlEvents: UIControlEventTouchDown];
    [midButton setImage:[UIImage imageNamed:@"middle_normal_small.png"] forState: UIControlStateNormal];
    [midButton setImage:[UIImage imageNamed:@"middle_pressed_small"] forState:UIControlStateHighlighted];
    midButton.tag = 104;
    [self.view addSubview: midButton];
    
    /* Back button */
    CGRect backButtonFrame = CGRectMake( 7, 315 + offsetAll, 50, 50 );
    UIButton *backButton = [[UIButton alloc] initWithFrame: backButtonFrame];
    [backButton addTarget: remoteControl     /* ClickListener*/
                   action: @selector(executeCommand:)
         forControlEvents: UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"Back_normal.png"] forState: UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"Back_pressed.png"] forState: UIControlStateHighlighted];
    backButton.tag = 105;
    [self.view addSubview: backButton];
    
    /* Settings button */
    CGRect settingsButtonFrame = CGRectMake( 71, 315 + offsetAll, 50, 50 );
    UIButton *settingsButton = [[UIButton alloc] initWithFrame: settingsButtonFrame];
    [settingsButton addTarget: remoteControl     /* ClickListener*/
                       action: @selector(executeCommand:)
             forControlEvents: UIControlEventTouchDown];
    [settingsButton setImage:[UIImage imageNamed:@"Settings_normal.png"] forState: UIControlStateNormal];
    [settingsButton setImage:[UIImage imageNamed:@"Settings_pressed.png"] forState: UIControlStateHighlighted];
    settingsButton.tag = 106;
    [self.view addSubview: settingsButton];
    
    /* Info button */
    CGRect infoButtonFrame = CGRectMake( 135, 315 + offsetAll, 50, 50 );
    UIButton *infoButton = [[UIButton alloc] initWithFrame: infoButtonFrame];
    [infoButton addTarget: remoteControl     /* ClickListener*/
                   action: @selector(executeCommand:)
         forControlEvents: UIControlEventTouchDown];
    [infoButton setImage:[UIImage imageNamed:@"Info_normal2.png"] forState: UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"Info_pressed.png"] forState: UIControlStateHighlighted];
    infoButton.tag = 107;
    [self.view addSubview: infoButton];
    
    /* Cancel button */
    CGRect cancelButtonFrame = CGRectMake( 199, 315 + offsetAll, 50, 50 );
    UIButton *cancelButton = [[UIButton alloc] initWithFrame: cancelButtonFrame];
    [cancelButton addTarget: remoteControl     /* ClickListener*/
                     action: @selector(executeCommand:)
           forControlEvents: UIControlEventTouchDown];
    [cancelButton setImage:[UIImage imageNamed:@"Cancel_normal.png"] forState: UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"Cancel_pressed.png"] forState: UIControlStateHighlighted];
    cancelButton.tag = 108;
    [self.view addSubview: cancelButton];
    
    /* Mute button */
    CGRect muteButtonFrame = CGRectMake( 263, 315 + offsetAll, 50, 50 );
    UIButton *muteButton = [[UIButton alloc] initWithFrame: muteButtonFrame];
    [muteButton addTarget: remoteControl     /* ClickListener*/
                   action: @selector(executeCommand:)
         forControlEvents: UIControlEventTouchDown];
    [muteButton setImage:[UIImage imageNamed:@"Unmute_normal.png"] forState: UIControlStateNormal];
    [muteButton setImage:[UIImage imageNamed:@"Mute_pressed.png"] forState: UIControlStateHighlighted];
    muteButton.tag = 109;
    [self.view addSubview: muteButton];
    
    /* The top bar with STB IP and volume control */
    UIView* topFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    topFrame.backgroundColor = [UIColor blackColor];
    [self.view addSubview: topFrame];
    [self.view bringSubviewToFront:topFrame];
    NSInteger topLineThickness = 2;
    UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0,topFrame.frame.size.height - topLineThickness, topFrame.frame.size.width, topLineThickness)];
    topLine.backgroundColor = RGBCOLOR(48, 180, 224);
    [topFrame addSubview:topLine];
    
    /* The volume slider at the top */
    volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, 0, (2*self.view.frame.size.width/5), 35)];
    [volumeSlider addTarget:self
                     action:@selector(sliderAction:)
           forControlEvents: UIControlEventValueChanged];
    [volumeSlider setBackgroundColor:[UIColor clearColor]];
    volumeSlider.minimumValue = 0.0;
    volumeSlider.maximumValue = 100.0;
    volumeSlider.continuous = NO;
    [volumeSlider setMinimumTrackTintColor:[UIColor blueColor]];
    volumeSlider.tag = 110;
    [remoteControl updateVolume:volumeSlider]; // Update volume slider value
    [topFrame addSubview:volumeSlider];
    
    /* Text field for the STB IP Address */
    STBIPaddress = [[UITextField alloc] initWithFrame:CGRectMake(0, 6, self.view.frame.size.width/3, 20)];
    [STBIPaddress setBackgroundColor:[UIColor blackColor]];
    STBIPaddress.textColor = [UIColor grayColor];
    STBIPaddress.font = [UIFont systemFontOfSize:14.0];
    STBIPaddress.autocorrectionType = UITextAutocorrectionTypeYes;
    STBIPaddress.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [STBIPaddress setUserInteractionEnabled:YES];
    STBIPaddress.placeholder = @"STB";
    STBIPaddress.tag = 300;
    [topFrame addSubview:STBIPaddress];
    [STBIPaddress setText:[remoteControl getIPAddress]];
    
    @try {
        /* The horizontal channel bar */
        NSInteger objectHeight = 75;
        channelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 4 + offsetAll, self.view.frame.size.width, objectHeight)];
        [channelScrollView setBackgroundColor: [UIColor clearColor]];
        channelScrollView.showsHorizontalScrollIndicator = false;
        [self.view addSubview: channelScrollView];
        channels = [remoteControl createChannels];
        NSInteger objectSpace = 0;
        NSInteger objectTag = 200; /* Start of the tag range for the channels. */
        float scale = 0.6; // Scale (size) of the icon
        NSInteger x = 0;
        for (VChannel* channel in channels) {
            UIImage* img = [channel getChannelIcon];
            UIButton* object = [[UIButton alloc] initWithFrame:CGRectMake(x, objectSpace, img.size.width*scale, img.size.height*scale)];
            [object setImage:img forState: UIControlStateNormal];
            object.tag = objectTag;
            [object addTarget: remoteControl     /* ClickListener */
                       action: @selector(executeCommand:)
             forControlEvents: UIControlEventTouchDown];
            [channel setTag: objectTag];
            [channel setIcon: object];
            [channelScrollView addSubview:[channel getIcon]];
            objectTag++;
            x += img.size.width*scale;
        }
        channelScrollView.contentSize = CGSizeMake( x - objectSpace, channelScrollView.frame.size.height);
        
    }
    @catch (NSException *exception) {
        channelViewLoaded = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Temp function.
- (void) buttonClicked: (id)sender {
    NSLog( @"Button clicked.");
}

- (NSString *)iconImageName {
	return @"2_remote_control_s.png" ;
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
    @try {
        [remoteControl getCurrentChannel];
        [remoteControl updateVolume:volumeSlider];
    }
    @catch (NSException *exception) {
        
    }
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

/* Removes the keyboard when pressing outside the text field */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [remoteControl setIPAddress:STBIPaddress.text];
    [super touchesBegan:touches withEvent:event];
    @try {
        [remoteControl getCurrentChannel];
        [remoteControl updateVolume:volumeSlider];
    }
    @catch (NSException *exception) {
        
    }

}

/* Updates the volume when sliding. */
-(void) sliderAction: (id) sender {
    [remoteControl setVolume:sender value:volumeSlider.value];
}




@end
