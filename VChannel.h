//
//  VChannel.h
//  BCTabBarController
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import <Foundation/Foundation.h>
//#import "VRemoteControlImpl.h"

@interface VChannel : NSObject {
    NSString * nameChannel;
    NSString * iconURL;
    NSInteger tag;
    NSObject* buttonObject;
    UIButton* icon;
    NSString* URL;
    
//    VRemoteControlImpl* remoteControl;
}

- (VChannel*)
              name: (NSString*) name
                nr: (NSInteger) nr
              onid: (NSInteger) onid
              tsid: (NSInteger) tsid
               sid: (NSInteger) sid;

-(UIImage*) getChannelIcon;
-(void) setTag: (NSInteger) tagIn;
-(NSInteger) getTag;
-(NSString*) getName;
-(void) setIcon: (UIButton*) buttonIn;
-(UIButton*) getIcon;
-(NSString*) getURL;
-(void) setURL: (NSString*) url;

@end
