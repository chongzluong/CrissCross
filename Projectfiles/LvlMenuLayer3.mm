//
//  MenuLayer.m
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "LvlMenuLayer3.h"
#import "HelloWorldLayer.h"

@interface LvlMenuLayer3(PrivateMethods)
@end

@implementation LvlMenuLayer3

-(id) init
{
    self= [super init];
    {
        [self setUpLevels];
    }
    return self;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	LvlMenuLayer3 *layer = [LvlMenuLayer3 node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpLevels
{
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:nil];
    //myMenu.position =CGPointZero;
    
    //Create menu buttons
    for (int k = 1; k<11; k++)
    {
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"lvl%ibutton.png", k]selectedImage:[NSString stringWithFormat:@"lvl%ibuttonselect.png", k] target:self selector:@selector(startLevel:)];
        menuItem.position = ccp(160, 160);
        menuItem.tag = k+30;
        [myMenu addChild:menuItem];
    }
    
    
	// Arrange the menu items vertically
	[myMenu alignItemsInColumns:[NSNumber numberWithUnsignedInt:2], [NSNumber numberWithUnsignedInt:2],[NSNumber numberWithUnsignedInt:2],[NSNumber numberWithUnsignedInt:2],[NSNumber numberWithUnsignedInt:2],nil];
    
    CCMenuItem *homeButton = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    homeButton.position = ccp(0, -200);
    
    [myMenu addChild:homeButton];
    
	// add the menu to your scene
	[self addChild:myMenu];

}

-(void) startLevel: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:menuItem.tag]];
}

-(void) goHome:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}


@end
