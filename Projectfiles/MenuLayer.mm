//
//  MenuLayer.mm
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "LvlMenuLayer.h"
#import "LvlMenuLayer2.h"
#import "LvlMenuLayer3.h"
#import "HighScoreMenu.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@interface MenuLayer (PrivateMethods)
@end

@implementation MenuLayer

-(id) init
{
    self= [super init];
    {
        [self setUpMenus];
    }
    return self;
}

+(id) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;

}

//set up the Menus
-(void) setUpMenus
{
    background = [CCSprite spriteWithFile:@"Screen Main Menu.png"];
    background.position = ccp(160,240);
    [self addChild:background];
    
    NSString *username = [MGWU objectForKey:[NSString stringWithFormat:@"username"]];
    
    //Lets the user input the name to go along with their high score
    inputter = [[UITextField alloc] initWithFrame:CGRectMake(40, 160, 240, 30)];
    inputter.borderStyle = UITextBorderStyleRoundedRect;
    inputter.font = [UIFont systemFontOfSize:14.0];
    inputter.placeholder = @"Enter a Username to Submit Scores!";
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
        inputter.placeholder = [NSString stringWithFormat:@"Current Username: %@",username];
    }
    
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play2.png" target:self selector:@selector(difficultyButtons:)];
    menuItem1.position = ccp(160, 230);
    menuItem1.tag = 1;
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"about.png" selectedImage:@"about2.png" target:self selector:@selector(about:)];
    menuItem2.position = ccp(160, 150);
    menuItem2.tag = 2;
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"MoreGames.png" selectedImage:@"MoreGames2.png" target:self selector:@selector(moreGames:)];
    menuItem3.position = ccp(160, 70);
    menuItem3.tag = 3;
    
    // Create a menu and add your menu items to it
	myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    myMenu.position =CGPointZero;
   
//Took out for v1
//    if (![MGWU isFacebookActive])
//    {
//        CCMenuItem *menuItem0 = [CCMenuItemImage itemFromNormalImage:@"FBLoginButton.png" selectedImage:@"FBLoginButtonPressed.png" target:self selector:@selector(fbLogin:)];
//        menuItem0.position = ccp(160, 280);
//        [myMenu addChild:menuItem0];
//    }
    
	// Arrange the menu items vertically
	//[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];

}

-(void) difficultyButtons:(CCMenuItem *) menuItem
{
    [inputter removeFromSuperview];
    [myMenu removeAllChildrenWithCleanup:YES];
 //   [self removeChild:myMenu cleanup:YES];
    
    CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"easy.png" selectedImage:@"easy2.png" target:self selector:@selector(startGame:)];
    menuItem1.position = ccp(160, 200);
    menuItem1.tag = 1;
    
    CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mediumbutton.png" selectedImage:@"mediumbutton.png" target:self selector:@selector(startGame2:)];
    menuItem2.position = ccp(160, 120);
    menuItem2.tag = 2;
    
    CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"hard.png" selectedImage:@"hard2.png" target:self selector:@selector(startGame3:)];
    menuItem3.position = ccp(160, 40);
    menuItem3.tag = 3;
    
    CCMenuItem *menuItem4 = [CCMenuItemImage itemFromNormalImage:@"hs3.png" selectedImage:@"hs4.png" target:self selector:@selector(highScores:)];
    menuItem4.position = ccp(160, 280);
    menuItem4.tag = 3;
    
	[myMenu addChild:menuItem1];
	[myMenu addChild:menuItem2];
	[myMenu addChild:menuItem3];
	[myMenu addChild:menuItem4];
    //CCMenu *newMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, nil];
   // newMenu.position = CGPointZero;
    
   // [self addChild:newMenu];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [MGWU setObject:inputter.text forKey:[NSString stringWithFormat:@"username"]];
    
    [textField removeFromSuperview];
    
    return YES;
    
}

-(void) about:(id)sender
{
#ifdef APPORTABLE
	[MGWU displayAboutMessage:@"Criss Cross was built by Timothy Luong!" andTitle:@"About Criss Cross"];
#else
	[MGWU displayAboutPage];
#endif
}

-(void) moreGames:(id)sender
{
    [MGWU displayCrossPromo];
}

-(void) startGame: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Super Kukicha.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Super Kukicha.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer scene]];
}

-(void) startGame2: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Pulse.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Pulse.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer2 scene]];
}

-(void) startGame3: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Dreadnought Machina.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Dreadnought Machina.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[LvlMenuLayer3 scene]];
}

-(void) highScores: (CCMenuItem *) menuItem
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Pulse.mp3"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Pulse.mp3" loop:TRUE];
    [[CCDirector sharedDirector] replaceScene:[HighScoreMenu scene]];
}

-(void) fbLogin:(id) sender
{
    [inputter removeFromSuperview];
    [MGWU loginToFacebook];
    [MGWU likeAppWithPageId:@"128509683968807"];
}

#ifdef APPORTABLE
-(void)androidBack
{
	exit(0);
}
#endif

@end
