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
}

+(id) scene;
-(void) startGame:(id) sender;
-(void) startGame2: (id) sender;
-(void) startGame3: (id) sender;
-(void) setUpMenus;

@end
