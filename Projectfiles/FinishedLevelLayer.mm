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
    
    
    timeLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score:%i", score] fontName:@"Futura-CondensedExtraBold" fontSize:14];
    timeLabel.position = ccp(160, 320);
    timeLabel.color = ccGREEN;
    [self addChild: timeLabel];

    
    if(score<3000)
    {
        CCSprite *boltscore = [CCSprite spriteWithFile:@"Score3.png"];
        boltscore.position = ccp(160,255);
        [self addChild:boltscore];
    }
    else if (score<6000)
    {
        CCSprite *boltscore = [CCSprite spriteWithFile:@"Score2.png"];
        boltscore.position = ccp(160,255);
        [self addChild:boltscore];
    }
    else if (score<12000)
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
    
    levelCompleted = finishedtag-1;
    
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
            //Lets the user input the name to go along with their high score
            inputter = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 240, 30)];
            inputter.borderStyle = UITextBorderStyleRoundedRect;
            inputter.font = [UIFont systemFontOfSize:14.0];
            inputter.placeholder = @"Enter A Name to Submit Your Score!";
            inputter.backgroundColor = [UIColor blackColor];
            inputter.keyboardType = UIKeyboardTypeDefault;
            inputter.returnKeyType = UIReturnKeyDone;
            inputter.clearButtonMode = UITextFieldViewModeWhileEditing;
            inputter.textColor = [UIColor blueColor];
            [inputter setBorderStyle:UITextBorderStyleLine];
            inputter.delegate = self;
            
            [[[CCDirector sharedDirector] openGLView] addSubview:inputter];
        }
    }
    
    currentHighScore = [MGWU objectForKey:[NSString stringWithFormat:@"Level%i highScore",levelCompleted]];
    hs = [currentHighScore intValue];
    
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
        bolts = [NSNumber numberWithInt:1];    }
    else
    {
        bolts = [NSNumber numberWithInt:0];
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
    
    [MGWU submitHighScore:-(score) byPlayer:inputter.text forLeaderboard:[NSString stringWithFormat:@"Level%iHighScores",levelCompleted]];
    [textField removeFromSuperview];
    
    return YES;
}

-(void) nextLevel: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer showLevel:finishedtag]];
}

-(void) goHome: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

-(void) highScoresList: (CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[HighScoreLayer showLevel:finishedtag]];
}

@end
