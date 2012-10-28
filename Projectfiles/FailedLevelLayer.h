//
//  FailedLevelLayer.h
//  Criss Cross
//
//  Created by Timothy on 10/20/12.
//
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"
#import "Box2D.h"
#import "cocos2d.h"

@interface FailedLevelLayer : CCLayer
{
    CCSprite *background;
}

+(id) scene;
+(id) showLevel: (int) i;
-(void) replayLevel:(id) sender;
-(void) goHome: (id) sender;
-(void) setupMenus;

@end
