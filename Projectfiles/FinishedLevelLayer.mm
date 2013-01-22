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
#import "HighScoreLayer.h"

int finishedtag = 0;
int score = 0;

@interface FinishedLevelLayer (PrivateMethods)
@end

@implementation FinishedLevelLayer

-(id) init
{
    self= [super init];
    {
        [self setUpMenus];
		[MGWU logEvent:@"level_completed" withParams:@{@"level":[NSNumber numberWithInt:finishedtag]}];
    }
    return self;
}

+(id) showLevel: (int) i timeOf: (int) k
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
    editingcounter = 0;
    
    background = [CCSprite spriteWithFile:@"Back.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    //Create menu buttons
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"YouWon.png" selectedImage:@"YouWon2.png" target:self selector:@selector(nextLevel:)];
    menuItem1.position = ccp(160, 160);
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
    menuItem2.position = ccp(160, 20);
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"s3.png" selectedImage:@"s4.png" target:self selector:@selector(highScoresList:)];
    menuItem3.position = ccp(155, 74);
    
    // Create a menu and add your menu items to it
	myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    myMenu.position =CGPointZero;
    
	// add the menu to your scene
	[self addChild:myMenu];
    
    if (finishedtag == 41)
    {
        [myMenu removeChild:menuItem1 cleanup:YES];
        CCMenuItem *menuItem4 = [CCMenuItemImage itemWithNormalImage:@"YouBeatTheGame.png" selectedImage:@"YouBeatTheGame2.png" target:self selector:@selector(goHome:)];
        menuItem4.position = ccp(160,160);
        [myMenu addChild:menuItem4];
    }
    
    timeLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score:%i", score] fontName:@"Futura-CondensedExtraBold" fontSize:14];
    timeLabel.position = ccp(160, 320);
    timeLabel.color = ccGREEN;
    [self addChild: timeLabel];

    levelCompleted = finishedtag-1;
    
    if (levelCompleted<21)
    {
        if (score < 6000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score3.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 9000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score2.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 12000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score1.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score0.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
    }
    else if (levelCompleted>20 && levelCompleted<36)
    {
        if (score < 9000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score3.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 12000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score2.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 18000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score1.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score0.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
    }
    else if (levelCompleted > 35 && levelCompleted <39)
    {
        if (score < 12000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score3.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 18000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score2.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 30000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score1.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score0.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
    }
    else if (levelCompleted > 38)
    {
        if (score < 60000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score3.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 120000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score2.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else if (score < 180000)
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score1.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
        else
        {
            CCSprite *boltscore = [CCSprite spriteWithFile:@"Score0.png"];
            boltscore.position = ccp(160,255);
            [self addChild:boltscore];
        }
    }
    
    tutorialLabel = [CCLabelTTF labelWithString:@"The Lower the Score, the Better!" fontName:@"Futura-CondensedExtraBold" fontSize:14];
    tutorialLabel.position = ccp(160, 340);
    tutorialLabel.color = ccGREEN;
    [self addChild:tutorialLabel];
    
    NSNumber *currentHighScore = [MGWU objectForKey:[NSString stringWithFormat:@"Level%i highScore",levelCompleted]];
    int hs = [currentHighScore intValue];
    
    bolts = [NSNumber numberWithInt:0];
    
    if (hs == 0 || hs>score)
    {
        NSNumber *highScore = [NSNumber numberWithInt:score];
        [MGWU setObject:highScore forKey:[NSString stringWithFormat:@"Level%i highScore",levelCompleted]];
        
        if ([MGWU isFacebookActive])
        {
            [MGWU submitHighScore:-(score) byPlayer:[MGWU getUsername] forLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",levelCompleted]];
        }
        else
        {
            NSString *username = [MGWU objectForKey:@"username"];
            
            //Lets the user input the name to go along with their high score
            inputter = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 240, 30)];
            inputter.borderStyle = UITextBorderStyleRoundedRect;
            inputter.font = [UIFont systemFontOfSize:14.0];
            inputter.placeholder = @"Enter to Change Your Username!";
            inputter.backgroundColor = [UIColor whiteColor];
            inputter.keyboardType = UIKeyboardTypeDefault;
            inputter.returnKeyType = UIReturnKeyDone;
            inputter.clearButtonMode = UITextFieldViewModeWhileEditing;
            inputter.textColor = [UIColor blackColor];
            [inputter setBorderStyle:UITextBorderStyleLine];
            inputter.delegate = self;
            
            [[[CCDirector sharedDirector] openGLView] addSubview:inputter];
            
            if (username)
            {
                [MGWU submitHighScore:-(score) byPlayer:username forLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",levelCompleted]];
                inputter.placeholder = [NSString stringWithFormat:@"Current Username: %@",username]; 
            }
            
        }
    }
    
    currentHighScore = [MGWU objectForKey:[NSString stringWithFormat:@"Level%i highScore",levelCompleted]];
    hs = [currentHighScore intValue];
    if (levelCompleted<21)
    {
        if (hs < 3000)
        {
            bolts = [NSNumber numberWithInt:3];
        }
        else if (hs < 6000)
        {
            bolts = [NSNumber numberWithInt:2];
        }
        else if (hs < 12000)
        {
            bolts = [NSNumber numberWithInt:1];
        }
        else
        {
            bolts = [NSNumber numberWithInt:0];
        }
    }
    else if (levelCompleted>20 && levelCompleted<36)
    {
        if (hs < 6000)
        {
            bolts = [NSNumber numberWithInt:3];
        }
        else if (hs < 12000)
        {
            bolts = [NSNumber numberWithInt:2];
        }
        else if (hs < 18000)
        {
            bolts = [NSNumber numberWithInt:1];
        }
        else
        {
            bolts = [NSNumber numberWithInt:0];
        }
    }
    else if (levelCompleted > 35)
    {
        if (hs < 12000)
        {
            bolts = [NSNumber numberWithInt:3];
        }
        else if (hs < 18000)
        {
            bolts = [NSNumber numberWithInt:2];
        }
        else if (hs < 30000)
        {
            bolts = [NSNumber numberWithInt:1];
        }
        else
        {
            bolts = [NSNumber numberWithInt:0];
        }
    }
    //[[NSUserDefaults standardUserDefaults] setObject:bolts forKey:[NSString stringWithFormat:@"Level%i bolts",levelCompleted]];
    [MGWU setObject:bolts forKey:[NSString stringWithFormat:@"Level%i bolts",levelCompleted]];
        
    highScoreLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Current HighScore:%i", hs] fontName:@"Futura-CondensedExtraBold" fontSize:14];
    highScoreLabel.position = ccp(160, 300);
    highScoreLabel.color = ccGREEN;
    [self addChild: highScoreLabel];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [MGWU setObject:inputter.text forKey:[NSString stringWithFormat:@"username"]];
    
    [MGWU submitHighScore:-(score) byPlayer:inputter.text forLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",levelCompleted]];
    [textField removeFromSuperview];
    
    return YES;
}

-(void) nextLevel: (CCMenuItem *) menuItem
{
    [inputter removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:finishedtag]];
}

-(void) goHome: (CCMenuItem *) menuItem
{
    [inputter removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

-(void) highScoresList: (CCMenuItem *) menuItem
{
    [inputter removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[HighScoreLayer showLevel:finishedtag type:1]];
}

@end
