//
//  BeginnerLvlMenuLayer.h
//  Criss Cross
//
//  Created by Timothy on 9/29/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "CCLayer.h"

@interface BeginnerLvlMenuLayer : CCLayer
{
    CCSprite *background;
}

+(id) scene;
-(void) startLevels:(id) self;
-(void) setUpLevels;
-(void) goHome:(id) sender;

@end
