//
//  FinishedLevelLayers.m
//  Criss Cross
//
//  Created by Timothy on 8/23/12.
//
//

#import "MenuLayer.h"
#import "FinishedLevelLayer.h"
#import "HelloWorldLayer.h"

int finishedtag = 0;
float score = 0.00;

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

+(id) showLevel: (int) i timeOf: (float) k
{
    finishedtag = i;
    score = k;
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
    background = [CCSprite spriteWithFile:@"Back.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    timeLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Time:%.2f", score] fontName:@"Futura-CondensedExtraBold" fontSize:14];
    timeLabel.position = ccp(160, 300);
    timeLabel.color = ccGREEN;
    [self addChild: timeLabel];
    
    int levelCompleted = finishedtag-1;
    
    NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Level%i highScore", levelCompleted]];
    float hs = [currentHighScore floatValue];
    
    bolts = [NSNumber numberWithInt:0];
    
    if (hs == 0 || hs>score)
    {
        NSNumber *highScore = [NSNumber numberWithFloat:score];
        [[NSUserDefaults standardUserDefaults] setObject:highScore forKey:[NSString stringWithFormat:@"Level%i highScore", levelCompleted]];
    }
    
    currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Level%i highScore", levelCompleted]];
    hs = [currentHighScore floatValue];
    
    if (hs < 30.0)
    {
        bolts = [NSNumber numberWithInt:3];
    }
    else if (hs < 60.0)
    {
        bolts = [NSNumber numberWithInt:2];
    }
    else if (hs < 120.0)
    {
        bolts = [NSNumber numberWithInt:1];
    }
    [[NSUserDefaults standardUserDefaults] setObject:bolts forKey:[NSString stringWithFormat:@"Level%i bolts",levelCompleted]];
    
    highScoreLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Current HighScore:%.2f", hs] fontName:@"Futura-CondensedExtraBold" fontSize:14];
    highScoreLabel.position = ccp(160, 280);
    highScoreLabel.color = ccGREEN;
    [self addChild: highScoreLabel];
    
    
    
    //Create menu buttons
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"YouWon.png" selectedImage:@"YouWon2.png" target:self selector:@selector(nextLevel:)];
    menuItem1.position = ccp(160, 200);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    menuItem2.position = ccp(160, 80);
    //menuItem2.tag = 2;
    
    // Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    myMenu.position =CGPointZero;
    
	// Arrange the menu items vertically
	//[myMenu alignItemsHorizontally];
    
	// add the menu to your scene
	[self addChild:myMenu];
    
}

-(void) nextLevel: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:finishedtag]];
}

-(void) goHome: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

@end
