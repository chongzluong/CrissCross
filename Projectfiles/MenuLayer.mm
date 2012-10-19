//
//  MenuLayer.mm
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "LvlMenuLayer.h"
#import "LvlMenuLayer2.h"
#import "LvlMenuLayer3.h"
#import "HelloWorldLayer.h"
#import "BeginnerHelloWorldLayer.h"
#import "BeginnerLvlMenuLayer.h"

@interface MenuLayer (PrivateMethods)
@end

@implementation MenuLayer

-(id) init
{
    self= [super init];
    {
        [self setUpMenus];
    }
    return self;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpMenus
{
    background = [CCSprite spriteWithFile:@"Screen Main Menu.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    /*
    //Create menu buttons
    CCMenuItem *menuItem0 = [CCMenuItemImage itemFromNormalImage:@"beginnerbutton.png" selectedImage:@"beginnerbuttonselect.png" target:self selector:@selector(startTutorial:)];
    menuItem0.position = ccp(160, 280);
    menuItem0.tag = 0;
    */
    
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"easy.png" selectedImage:@"easy2.png" target:self selector:@selector(startGame:)];
    menuItem1.position = ccp(160, 200);
    menuItem1.tag = 1;
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mediumbutton.png" selectedImage:@"mediumbutton.png" target:self selector:@selector(startGame2:)];
    menuItem2.position = ccp(160, 120);
    menuItem2.tag = 2;
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"hard.png" selectedImage:@"hard2.png" target:self selector:@selector(startGame3:)];
    menuItem3.position = ccp(160, 40);
    menuItem3.tag = 3;
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    myMenu.position =CGPointZero;
    
	// Arrange the menu items vertically
	//[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];

}

-(void) startTutorial:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[BeginnerLvlMenuLayer scene]];
}

-(void) startGame: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer scene]];
}

-(void) startGame2: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer2 scene]];
}

-(void) startGame3: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer3 scene]];
}
@end
