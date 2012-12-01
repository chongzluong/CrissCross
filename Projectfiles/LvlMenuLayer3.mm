//
//  LvlMenu3.m
//  Criss Cross
//
//  Created by Timothy on 8/23/12.
//
//

#import "MenuLayer.h"
#import "LvlMenuLayer3.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@implementation LvlMenuLayer3(PrivateMethods)
@end

@implementation LvlMenuLayer3

-(id) init
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
	LvlMenuLayer3 *layer = [LvlMenuLayer3 node];
    
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
    for (int k = 36; k<41; k++)
    {
        //NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Level%i highScore", k-1]];
        NSNumber *currentHighScore = [MGWU objectForKey:[NSString stringWithFormat:@"Level%i highScore",k-1]];
        float hs = [currentHighScore floatValue];
        
        if(hs!=0||k==36)
        {
            //NSNumber *currentBoltNumber = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Level%i bolts",k]];
            NSNumber *currentBoltNumber = [MGWU objectForKey:[NSString stringWithFormat:@"Level%i bolts",k]];
            int bolts = [currentBoltNumber intValue];
            
            CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"lvl%ibutton%i.png", k,bolts]selectedImage:[NSString stringWithFormat:@"lvl%ibutton%i.png", k,bolts] target:self selector:@selector (startLevel:)];
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
	[myMenu alignItemsInColumns:[NSNumber numberWithUnsignedInt:1], [NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],nil];
    
    myMenu.position=ccp(160,195);
    
    CCMenuItem *homeButton = [CCMenuItemImage itemFromNormalImage:@"home.png" selectedImage:@"home2.png" target:self selector:@selector(goHome:)];
    homeButton.position = ccp(0, -176);
    
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
