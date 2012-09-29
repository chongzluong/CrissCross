//
//  BeginnerFinishedLevelLayer.h
//  Criss Cross
//
//  Created by Timothy on 9/29/12.
//
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface BeginnerFinishedLevelLayer : CCLayer

+(id) scene;
+(id) showLevel: (int) i; 
-(void) nextLevel:(id) sender;
-(void) goHome: (id) sender;
-(void) setUpMenus;

@end
