#import "BCTabBarView.h"
#import "BCTabBar.h"

@implementation BCTabBarView
@synthesize tabBar, contentView;

- (void)setTabBar:(BCTabBar *)aTabBar {
    if (tabBar != aTabBar) {
        [tabBar removeFromSuperview];
        tabBar = aTabBar;
        
        [self addSubview:tabBar];
//        [self sendSubviewToBack:tabBar];
    }
}

- (void)setContentView:(UIView *)aContentView {
	[contentView removeFromSuperview];
	contentView = aContentView;
    
    /* Sets the fra of the tabbed vies (RC/EPG etc) */
	contentView.frame = CGRectMake(0, 0, self.bounds.size.width,  0);
	[self addSubview:contentView];
	[self sendSubviewToBack:contentView];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect f = contentView.frame;
    //	f.size.height = self.tabBar.frame.origin.y+100; // Height of view
    f.size.height = self.bounds.size.height;
	contentView.frame = f;
	[contentView layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	[RGBCOLOR(230, 230, 230) set];
	CGContextFillRect(c, self.bounds);
}

@end
