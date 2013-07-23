//
//  HighScoreMenu2.m
//  Criss Cross
//
//  Created by Timothy on 11/30/12.
//
//

#import "HighScoreMenu.h"
#import "HighScoreMenu2.h"
#import "MenuLayer.h"
#import "HighScoreLayer.h"
#import "HighScoreLayer2.h"
#import "SimpleAudioEngine.h"

@interface HighScoreMenu2 (PrivateMethods)
@end

@implementation HighScoreMenu2

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
	HighScoreMenu2 *layer = [HighScoreMenu2 node];
    
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
    myMenu.position = CGPointZero;
    
    //Create menu buttons
    for (int k = 21; k<41; k++)
    {
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"lvl%ibutton.png", k]selectedImage:[NSString stringWithFormat:@"lvl%ibutton.png", k] target:self selector:@selector (startLevel:)];
        menuItem.position = ccp(160, 160);
        menuItem.tag = k;
        [myMenu addChild:menuItem];
    }
    
    // Arrange the menu items vertically
	[myMenu alignItemsInColumns:[NSNumber numberWithUnsignedInt:4], [NSNumber numberWithUnsignedInt:4],[NSNumber numberWithUnsignedInt:4], [NSNumber numberWithUnsignedInt:4], [NSNumber numberWithUnsignedInt:4],nil];
    
    myMenu.position = ccp(160,195);
    
    CCMenuItem *homeButton = [CCMenuItemImage itemFromNormalImage:@"home.png" selectedImage:@"home2.png" target:self selector:@selector(goHome:)];
    homeButton.position = ccp(-20, -176);
    [myMenu addChild:homeButton];
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"previous.png" selectedImage:@"previousselect.png" target:self selector:@selector(previousList:)];
    menuItem2.position = ccp(20,-176);
    [myMenu addChild:menuItem2];
    
	// add the menu to your scene
	[self addChild:myMenu];
}

-(void) startLevel: (CCMenuItemImage *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HighScoreLayer showLevel:menuItem.tag+1 type:2]];
}

-(void) goHome:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

-(void) previousList: (CCMenuItemImage *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HighScoreMenu scene]];
}

#ifdef APPORTABLE
-(void)androidBack
{
	[[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
	
	[MGWU logEvent:@"android_back_pressed"];
}

-(void)androidMenu
{
	[[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
	
	[MGWU logEvent:@"android_menu_pressed"];
}
#endif

@end
