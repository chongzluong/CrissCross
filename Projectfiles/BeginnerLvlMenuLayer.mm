//
//  BeginnerLvlMenuLayer.mm
//  Criss Cross
//
//  Created by Timothy on 9/29/12.
//
//

#import "BeginnerLvlMenuLayer.h"
#import "MenuLayer.h"
#import "BeginnerHelloWorldLayer.h"

@implementation BeginnerLvlMenuLayer (PrivateMethods)
@end

@implementation BeginnerLvlMenuLayer

-(id)init
{
    self = [super init];
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
    BeginnerLvlMenuLayer *layer = [BeginnerLvlMenuLayer node];
    
    // add layer as a child to scene
    [scene addChild:layer];
    
    //return the scene
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
    for (int k = 1; k<6; k++)
    {
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"lvl%ibutton.png", k]selectedImage:[NSString stringWithFormat:@"lvl%ibutton.png", k] target:self selector:@selector(startLevels:)];
        menuItem.position = ccp(160, 160);
        menuItem.tag = k;
        [myMenu addChild:menuItem];
    }
    
    
	// Arrange the menu items vertically
	[myMenu alignItemsInColumns:[NSNumber numberWithUnsignedInt:1], [NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],nil];
    
    myMenu.position = ccp(160,170);
    
    /*
    CCMenuItem *homeButton = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    homeButton.position = ccp(0, -200);
    
    [myMenu addChild:homeButton];
    */
    
	// add the menu to your scene
	[self addChild:myMenu];
    
}

-(void) startLevels: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[BeginnerHelloWorldLayer showLevel:menuItem.tag]];
}

-(void) goHome:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
    
}
@end
