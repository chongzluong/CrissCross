//
//  HighScoreLayer.h
//  Criss Cross
//
//  Created by Timothy on 11/16/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface HighScoreLayer : CCLayer
{
    CCSprite *background;
    NSDictionary *item;
    NSNumber *score;
    NSString *name;
    CCLabelTTF *nameLabel;
    CCLabelTTF *scoreLabel;
    float intScore;
    int xvalue;
    int yvalue;
}

+(id) scene;
+(id) showLevel: (int) i;
-(void) goBack: (id) sender;
-(void) setupMenus;
-(void) receivedScores: (NSDictionary*) scores;

@end
