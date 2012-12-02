//
//  VChannel.m
//  BCTabBarController
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import "VChannel.h"
#import "VRemoteControlImpl.h"

@implementation VChannel {
    
}

- (VChannel*)
              name: (NSString*) name
                nr: (NSInteger) nr
              onid: (NSInteger) onid
              tsid: (NSInteger) tsid
               sid: (NSInteger) sid
{
    if (self) {
        NSMutableString *iconURLTemp = [[NSMutableString alloc] init];
        [iconURLTemp appendString:@"http://130.236.248.226/data/channelicon%3fonid="];
        [iconURLTemp appendString:[NSString stringWithFormat:@"%d",onid]];
        [iconURLTemp appendString:@"&tsid="];
        [iconURLTemp appendString:[NSString stringWithFormat:@"%d",tsid]];
        [iconURLTemp appendString:@"&sid="];
        [iconURLTemp appendString:[NSString stringWithFormat:@"%d",sid]];
        iconURL = iconURLTemp;
        nameChannel = name;
        return self;
    }
    return nil;
}

-(UIImage*) getChannelIcon  {
    VRemoteControlImpl* remoteControl = [[VRemoteControlImpl alloc] init];
    return [remoteControl getChannelIcon:iconURL];
}

-(void) setTag: (NSInteger) tagIn {
    tag = tagIn;
}

-(NSInteger) getTag {
    return tag;
}

-(NSString*) getName {
    return nameChannel;
}

-(void) setIcon: (UIButton*) buttonIn {
    icon = buttonIn;
}

-(UIButton*) getIcon {
    return icon;
}
-(NSString*) getURL {
    return URL;
}
-(void)setURL: (NSString*) url {
    URL = url;
}

@end
