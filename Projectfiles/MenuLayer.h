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

enum
 {
 kTagBatchNode,
 };


@interface MenuLayer : CCLayer
{
    CCSprite *background;
    CCMenu *myMenu;
}

+(id) scene;
-(void) about:(id) sender;
-(void) moreGames: (id) sender;
-(void) difficultyButtons: (id) sender;
-(void) startGame:(id) sender;
-(void) startGame2: (id) sender;
-(void) startGame3: (id) sender;
-(void) highScores: (id) sender;
-(void) setUpMenus;
-(void) fbLogin: (id) sender;

@end
