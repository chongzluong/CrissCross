//
//  MenuLayer.h
//  Test2
//
//  Created by Timothy on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

/*
enum
 {
 kTagBatchNode,
 };
*/

@interface LvlMenuLayer : CCLayer
{
    CCSprite *background;
}

+(id) scene;
-(void) startLevel:(id) self;
-(void) setUpLevels;
-(void) goHome:(id) sender;

@end
