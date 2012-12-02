//
//  VRemoteControlViewController.h
//  TestApp
//
//  Created by Viktor Dahl on 2012-11-26.
//  Copyright (c) 2012 Viktor Dahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRemoteControlImpl.h"
//@class VRemoteControlImpl;
@interface ZRemoteControlViewController : UIViewController
{
    VRemoteControlImpl* remoteControl;
    NSMutableArray* channels;
    UIScrollView *channelScrollView;
    UITextField * STBIPaddress;
    UISlider* volumeSlider;
    BOOL Active;

}

-(void) setActiveChannel;
-(void) sliderAction: (id) sender;

@end
