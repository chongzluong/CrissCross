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
#import "HighScoreMenu.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

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
    
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play2.png" target:self selector:@selector(difficultyButtons:)];
    menuItem1.position = ccp(160, 200);
    menuItem1.tag = 1;
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"about.png" selectedImage:@"about2.png" target:self selector:@selector(about:)];
    menuItem2.position = ccp(160, 120);
    menuItem2.tag = 2;
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"MoreGames.png" selectedImage:@"MoreGames2.png" target:self selector:@selector(moreGames:)];
    menuItem3.position = ccp(160, 40);
    menuItem3.tag = 3;
    
    // Create a menu and add your menu items to it
	myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    myMenu.position =CGPointZero;
    
    if (![MGWU isFacebookActive])
    {
        CCMenuItem *menuItem0 = [CCMenuItemImage itemFromNormalImage:@"FBLoginButton.png" selectedImage:@"FBLoginButtonPressed.png" target:self selector:@selector(fbLogin:)];
        menuItem0.position = ccp(160, 280);
        [myMenu addChild:menuItem0];
    }
    
	// Arrange the menu items vertically
	//[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];

}

-(void) difficultyButtons:(CCMenuItem *) menuItem
{
    [myMenu removeAllChildrenWithCleanup:YES];
    [self removeChild:myMenu cleanup:YES];
    
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"easy.png" selectedImage:@"easy2.png" target:self selector:@selector(startGame:)];
    menuItem1.position = ccp(160, 200);
    menuItem1.tag = 1;
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mediumbutton.png" selectedImage:@"mediumbutton.png" target:self selector:@selector(startGame2:)];
    menuItem2.position = ccp(160, 120);
    menuItem2.tag = 2;
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"hard.png" selectedImage:@"hard2.png" target:self selector:@selector(startGame3:)];
    menuItem3.position = ccp(160, 40);
    menuItem3.tag = 3;
    
    CCMenuItem *menuItem4 = [CCMenuItemImage itemFromNormalImage:@"hs3.png" selectedImage:@"hs4.png" target:self selector:@selector(highScores:)];
    menuItem4.position = ccp(160, 280);
    menuItem4.tag = 3;
    
    CCMenu *newMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, nil];
    newMenu.position = CGPointZero;
    
    [self addChild:newMenu];
}

-(void) about:(id)sender
{
    [MGWU displayAboutPage];
}

-(void) moreGames:(id)sender
{
    [MGWU displayCrossPromo];
}

-(void) startGame: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Super Kukicha.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Super Kukicha.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer scene]];
}

-(void) startGame2: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Pulse.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Pulse.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer2 scene]];
}

-(void) startGame3: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Dreadnought Machina.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Dreadnought Machina.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer3 scene]];
}

-(void) highScores: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Fragments.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Fragments.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[HighScoreMenu scene]];
}

-(void) fbLogin:(id) sender
{
    [MGWU loginToFacebook];
    [MGWU likeAppWithPageId:@"128509683968807"];
}

@end
