//
//  HighScoreLayer2.m
//  Criss Cross
//
//  Created by Timothy on 11/23/12.
//
//

#import "HighScoreLayer.h"
#import "HighScoreLayer2.h"
#import "FinishedLevelLayer.h"
#import "LvlMenuLayer.h"
#import "LvlMenuLayer2.h"
#import "LvlMenuLayer3.h"

int level = 0;

@interface HighScoreLayer2 (PrivateMethods)
@end

@implementation HighScoreLayer2

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
	HighScoreLayer2 *layer = [HighScoreLayer2 node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
    
}


+(id) showLevel:(int)i
{
    level = i-1;
    CCScene* myScene = [HighScoreLayer2 scene];
    return myScene;
}

-(void) setupMenus
{
    background = [CCSprite spriteWithFile:@"High Scores Blank.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    [MGWU getHighScoresForLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",level] withCallback:@selector(receivedScores:) onTarget:self];
    
    CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goBack:)];
    menuItem.position = ccp(160, 20);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"previous.png" selectedImage:@"previousselect.png" target:self selector:@selector(previousList:)];
    menuItem2.position = ccp(160,60);
    
    CCMenu *myMenu = [CCMenu menuWithItems:menuItem, menuItem2, nil];
    myMenu.position = CGPointZero;
    
    [self addChild:myMenu];
}

-(void) goBack:(id)sender
{
    if(level<16)
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer scene]];
    }
    else if(level<31&&level>15)
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer2 scene]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer3 scene]];
    }
}

-(void) previousList: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HighScoreLayer showLevel:level+1]];
}

-(void) receivedScores:(NSDictionary *)scores
{
    //Check what's in the scores
    for (NSString *key in [scores allKeys])
    {
        NSLog(@"%@",[scores objectForKey:key]);
    }
    
    NSArray *tempArray = [scores objectForKey:@"all"];
    
    CCLabelTTF *WordName = [CCLabelTTF labelWithString:@"Name" fontName:@"Futura-CondensedExtraBold" fontSize:14];
    CCLabelTTF *WordScore = [CCLabelTTF labelWithString:@"Score" fontName:@"Futura-CondensedExtraBold" fontSize:14];
    CCLabelTTF *WordRank = [CCLabelTTF labelWithString:@"Rank" fontName:@"Futura-CondensedExtraBold" fontSize:14];
    
    WordName.position = ccp(170,400);
    WordScore.position = ccp(220,400);
    WordRank.position = ccp(100,400);
    
    WordName.color = ccBLUE;
    WordScore.color = ccBLUE;
    WordRank.color = ccBLUE;
    
    [self addChild:WordName];
    [self addChild:WordScore];
    [self addChild:WordRank];
    
    int x = [tempArray count];
    //Limit the highscore list to 20
    if (x>20)
    {
        x=20;
    }
    for (int k = 0; k<x; k++)
    {
        item = [tempArray objectAtIndex:k];
        name = [item objectForKey:@"name"];
        score = [item objectForKey:@"score"];
        CCLabelTTF *nameLabel = [CCLabelTTF labelWithString:name fontName:@"Futura-CondensedExtraBold" fontSize:14];
        intScore = -[score intValue];
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",intScore] fontName:@"Futura-CondensedExtraBold" fontSize:14];
        CCLabelTTF *rankLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",k+1] fontName:@"Futura-CondensedExtraBold" fontSize:14];
        yvalue = 380-k*15;
        rankLabel.position = ccp(100,yvalue);
        nameLabel.position = ccp(170,yvalue);
        scoreLabel.position = ccp(220,yvalue);
        rankLabel.color = ccBLUE;
        nameLabel.color = ccBLUE;
        scoreLabel.color = ccBLUE;
        [self addChild:rankLabel];
        [self addChild:nameLabel];
        [self addChild:scoreLabel];
    }
}

@end