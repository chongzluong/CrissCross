//
//  HighScoreLayer.m
//  Criss Cross
//
//  Created by Timothy on 11/16/12.
//
//

#import "HighScoreLayer.h"
#import "FinishedLevelLayer.h"
#import "LvlMenuLayer.h"
#import "LvlMenuLayer2.h"
#import "LvlMenuLayer3.h"

int levelCompleted = 0;

@interface HighScoreLayer (PrivateMethods)
@end

@implementation HighScoreLayer

-(id) init
{
    self = [super init];
    {
        [self setupMenus];
    }
    return self;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	HighScoreLayer *layer = [HighScoreLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
    
}


+(id) showLevel:(int)i
{
    levelCompleted = i-1;
    CCScene* myScene = [HighScoreLayer scene];
    return myScene;
}

-(void) setupMenus
{
    background = [CCSprite spriteWithFile:@"Back.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    [MGWU getHighScoresForLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",levelCompleted] withCallback:@selector(receivedScores:) onTarget:self];
    
    CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"previous.png" selectedImage:@"previousselect.png" target:self selector:@selector(goBack:)];
    menuItem.position = ccp(160, 20);
    
    CCMenu *myMenu = [CCMenu menuWithItems:menuItem, nil];
    myMenu.position = CGPointZero;
    
    [self addChild:myMenu];
}

-(void) goBack:(id)sender
{
    if(levelCompleted<16)
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer scene]];
    }
    else if(levelCompleted<31&&levelCompleted>15)
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer2 scene]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer3 scene]];
    }
}

-(void) receivedScores:(NSDictionary *)scores
{
    for (NSString *key in [scores allKeys])
    {
        NSLog(@"%@",[scores objectForKey:key]);
    }
    
    NSArray *tempArray = [scores objectForKey:@"all"];
    for (int k = 0; k<(int)[tempArray count]; k++)
    {
        item = [tempArray objectAtIndex:k];
        name = [item objectForKey:@"name"];
        score = [item objectForKey:@"score"];
        nameLabel = [CCLabelTTF labelWithString:name fontName:@"Futura-CondensedExtraBold" fontSize:14];
        floatScore = -[score floatValue];
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.2f",floatScore] fontName:@"Futura-CondensedExtraBold" fontSize:14];
        yvalue = 330-k*10;
        nameLabel.position = ccp(100,yvalue);
        scoreLabel.position = ccp(200,yvalue);
        nameLabel.color = ccBLUE;
        scoreLabel.color = ccBLUE;
        [self addChild:nameLabel];
        [self addChild:scoreLabel];
        
    }
}

@end
