//
//  MenuLayer.mm
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "FinishedLevelLayer.h"
#import "LvlMenuLayer.h"
#import "LvlMenuLayer2.h"
#import "HelloWorldLayer.h"

int finishedtag = 0;
@interface FinishedLevelLayer (PrivateMethods)
@end

@implementation FinishedLevelLayer

-(id) init
{
    self= [super init];
    {
        [self setUpMenus];
    }
    return self;
}

+(id) showLevel: (int) i
{
    finishedtag = i;
    CCScene* myScene = [FinishedLevelLayer scene];
    return myScene;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	FinishedLevelLayer *layer = [FinishedLevelLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpMenus
{
    
    NSString *title = @"Level Complete!";
    CCLabelTTF *label = [CCLabelTTF labelWithString:title fontName:@"AvenirNext-Heavy" fontSize:35];
    label.position = [CCDirector sharedDirector].screenCenter;
    label.color =ccGREEN;
    [self addChild:label];
    
    
    //Create menu buttons
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"NextLevel.png" selectedImage:@"NextLevelSelect.png" target:self selector:@selector(startGame:)];
    menuItem1.position = ccp(160, 160);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(startGame2:)];
    menuItem2.position = ccp(160, 120);
    menuItem2.tag = 2;
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    myMenu.position =CGPointZero;
    
	// Arrange the menu items vertically
	[myMenu alignItemsHorizontally];
    
	// add the menu to your scene
	[self addChild:myMenu];

}

-(void) startGame: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:finishedtag]];
}

-(void) startGame2: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

@end
