//
//  FinishedLevelLayers.h
//  Criss Cross
//
//  Created by Timothy on 8/23/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"


@interface FinishedLevelLayer: CCLayer <UITextFieldDelegate>
{
    CCSprite *background;
    CCLabelTTF *timeLabel;
    CCLabelTTF *highScoreLabel;
    CCLabelTTF *tutorialLabel;
    CCMenu *myMenu;
    NSNumber *bolts;
    UITextField *inputter;
    int editingcounter;
    int levelCompleted;
}

+(id) scene;
+(id) showLevel: (int) i timeOf: (int) k;
-(void) nextLevel:(id) sender;
-(void) goHome: (id) sender;
-(void) setUpMenus;
-(void) highScoresList: (id) sender;

@end
