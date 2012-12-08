//
//  FailedLevelLayer.m
//  Criss Cross
//
//  Created by Timothy on 10/20/12.
//
//

#import "FailedLevelLayer.h"
#import "MenuLayer.h"
#import "HelloWorldLayer.h"

int failedtag = 0;

@interface FailedLevelLayer (PrivateMethods)
@end

@implementation FailedLevelLayer

-(id) init
{
    self = [super init];
    {
        [self setupMenus];
		[MGWU logEvent:@"level_failed" withParams:@{@"level":[NSNumber numberWithInt:failedtag]}];
    }
    return self;
}

+(id) showLevel:(int)i
{
    failedtag = i;
    CCScene* myScene = [FailedLevelLayer scene];
    return myScene;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	FailedLevelLayer *layer = [FailedLevelLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
    
}

//set up the Menus
-(void) setupMenus
{
    background = [CCSprite spriteWithFile:@"Back.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    //Create menu buttons
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"WrongPorts.png" selectedImage:@"WrongPorts2.png" target:self selector:@selector(replayLevel:)];
    menuItem1.position = ccp(140,200);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    menuItem2.position = ccp(160, 80);
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    myMenu.position =CGPointZero;
    
    //add the menu to your scene
    [self addChild:myMenu];
    
}

-(void) replayLevel: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:failedtag]];
}

-(void) goHome: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

@end
