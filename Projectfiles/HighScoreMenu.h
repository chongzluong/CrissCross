//
//  HighScoreMenu.h
//  Criss Cross
//
//  Created by Timothy on 11/30/12.
//
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface HighScoreMenu : CCLayer
{
    CCSprite *background;
}

+(id) scene;
-(void) startLevel:(id) self;
-(void) setUpLevels;
-(void) goHome:(id) sender;
-(void) nextList:(id) sender;

@end
