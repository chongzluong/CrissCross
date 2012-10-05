//
//  BeginnerFinishedLevelLayer.m
//  Criss Cross
//
//  Created by Timothy on 9/29/12.
//
//

#import "BeginnerFinishedLevelLayer.h"
#import "MenuLayer.h"
#import "BeginnerHelloWorldLayer.h"
#import "HelloWorldLayer.h"

int finishedleveltag = 0;

@implementation BeginnerFinishedLevelLayer (PrivateMethods)
@end

@implementation BeginnerFinishedLevelLayer

-(id) init
{
    self = [super init];
    {
        [self setUpMenus];
    }
    return self;
}

+(id) showLevel:(int)i
{
    finishedleveltag = i;
    CCScene* myScene = [BeginnerFinishedLevelLayer scene];
    return myScene;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	BeginnerFinishedLevelLayer *layer = [BeginnerFinishedLevelLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpMenus
{
    background = [CCSprite spriteWithFile:@"Back.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    //Create menu buttons
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"YouWon.png" selectedImage:@"YouWon2.png" target:self selector:@selector(nextLevel:)];
    menuItem1.position = ccp(160, 200);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    menuItem2.position = ccp(160, 80);
    menuItem2.tag = 2;
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    myMenu.position =CGPointZero;
    
    [self addChild:myMenu];
}

-(void)nextLevel:(CCMenuItem *) menuItem
{
    if (finishedleveltag == 6)
    {
        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:1]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[BeginnerHelloWorldLayer showLevel:finishedleveltag]];
    }
}

-(void) goHome:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}
@end
