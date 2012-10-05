//
//  MenuLayer.m
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "LvlMenuLayer2.h"
#import "HelloWorldLayer.h"

@interface LvlMenuLayer2(PrivateMethods)
@end

@implementation LvlMenuLayer2

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
	LvlMenuLayer2 *layer = [LvlMenuLayer2 node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpLevels
{
    
    background = [CCSprite spriteWithFile:@"LevelSelect.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:nil];
    //myMenu.position =CGPointZero;
    
    //Create menu buttons
    for (int k = 16; k<31; k++)
    {
        NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Level%i highScore", k-1]];
        float hs = [currentHighScore floatValue];
        
        if(hs!=0||k==16)
        {
            CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"lvl%ibutton.png", k]selectedImage:[NSString stringWithFormat:@"lvl%ibutton.png", k] target:self selector:@selector (startLevel:)];
            menuItem.position = ccp(160, 160);
            menuItem.tag = k;
            [myMenu addChild:menuItem];
        }
        else
        {
            CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"locked.png" selectedImage:@"locked.png"];
            menuItem.position = ccp(160,160);
            [myMenu addChild:menuItem];
        }
    }
    
    
	// Arrange the menu items vertically
	[myMenu alignItemsInColumns:[NSNumber numberWithUnsignedInt:3], [NSNumber numberWithUnsignedInt:3],[NSNumber numberWithUnsignedInt:3],[NSNumber numberWithUnsignedInt:3],[NSNumber numberWithUnsignedInt:3],nil];
    
    myMenu.position = ccp(160,170);
    
    /*
    CCMenuItem *homeButton = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    homeButton.position = ccp(0, -200);
    
    [myMenu addChild:homeButton];
    */
    
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