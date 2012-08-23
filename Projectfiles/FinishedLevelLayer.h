//
//  FinishedLevelLayers.h
//  Criss Cross
//
//  Created by Timothy on 8/23/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"


@interface FinishedLevelLayer: CCLayer
{
    CCLabelTTF *timeLabel;
    CCLabelTTF *highScoreLabel;
}

+(id) scene;
+(id) showLevel: (int) i timeOf: (float) k;
-(void) nextLevel:(id) sender;
-(void) goHome: (id) sender;
-(void) setUpMenus;

@end
