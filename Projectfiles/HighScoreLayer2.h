//
//  HighScoreLayer2.h
//  Criss Cross
//
//  Created by Timothy on 11/23/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface HighScoreLayer2 : CCLayer
{
    CCSprite *background;
    NSDictionary *item;
    NSNumber *score;
    NSString *name;
    int intScore;
    int xvalue;
    int yvalue;
}

+(id) scene;
+(id) showLevel: (int) i type:(int)k;
-(void) goBack: (id) sender;
-(void) previousList: (id) sender;
-(void) setupMenus;
-(void) receivedScores: (NSDictionary*) scores;

@end