//
//  VMainViewController.h
//  TestApp
//
//  Created by Viktor Dahl on 2012-11-27.
//  Copyright (c) 2012 Viktor Dahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VRemoteControlImpl;

@interface ZMainViewController : UIViewController {
    VRemoteControlImpl* remoteControl;
    UITextField * STBIPaddress;
}
@end
