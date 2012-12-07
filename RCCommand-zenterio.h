//
//  RCCommand-zenterio.h
//  Zmote-new
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import <Foundation/Foundation.h>

@interface RCCommand_zenterio : NSObject {
    NSString* IPAddr;
}
-(RCCommand_zenterio*) init;
- (void) URLRequest: (NSString*) url;
- (UIImage*) getChannelIcon: (NSString*)iconURL;
- (NSDictionary*) getEPG;
- (NSInteger) getVolume;
- (void) sendRequest: (NSString*) command;
- (NSString*) getCurrentChannel;
-(void) changeChannel: (NSString*) url;
-(NSString*) getIPAddress;
-(void) setIPAddress: (NSString*) IPAddress;
-(void) setVolume: (float) val;

@end
