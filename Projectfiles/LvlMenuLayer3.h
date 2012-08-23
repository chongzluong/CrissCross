//
//  LvlMenu3.h
//  Criss Cross
//
//  Created by Timothy on 8/23/12.
//
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

@interface LvlMenuLayer3 : CCLayer

+(id) scene;
-(void) startLevel:(id) self;
-(void) setUpLevels;
-(void) goHome:(id) sender;

@end