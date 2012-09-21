/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
	NSString* helloWorldString;
	NSString* helloWorldFontName;
	int helloWorldFontSize;
    NSDictionary *item;
    NSNumber *x;
    NSNumber *y;
    NSNumber *x2;
    NSNumber *y2;
    NSMutableArray *startpoints;
    NSMutableArray *endpoints; 
    NSMutableArray *points;
    NSMutableArray *colors;
    NSMutableArray *gate;
    NSMutableArray *teleporters;
    int counter;
    CGPoint blah;
    CGPoint blah2;
    float speed;
    CCSprite *target;
    int startCounter;
    int samePointCounter;
    int winCounter;
    CCMenu *tempMenu;
    CCMenuItem *startButton;
    CCMenuItem *restartButton;
    CCMenuItem *clearButton;
    CCMenuItem *previousButton;
    CCMenuItem *homeButton;
    NSDictionary *test;
    NSArray *colored;
    NSArray *startlines;
    NSArray *vertlines;
    NSArray *gates;
    NSArray *teleporterArray;
    float yellowlength;
    float redlength;
    float bluelength;
    float pinklength;
    float greenlength;
    
    CGPoint yellowdestination;
    CGPoint reddestination;
    CGPoint bluedestination;
    CGPoint pinkdestination;
    CGPoint greendestination;
    
    NSDate *start;
    NSTimeInterval timeInterval;
    NSNumber *time;
    CCLabelTTF *timeLabel;
}

+(id) showLevel: (int) i;
+(id) scene;
-(void) changeLength: (float) length color:(int) k destination:(CGPoint)temp;
-(void) subtractLength: (float) difference color:(int) k;
-(float) whichLength: (int) k;
-(void) deleteLength: (int) k;
-(CGPoint) whichDestination: (int) k;
-(float) smallestDistanceFromPoint: (CGPoint) point;
-(float) smallestDistanceFromGate: (CGPoint) point;
-(float) smallestDistanceFromTeleporter: (CGPoint) point;

-(CGPoint) closestPoint: (CGPoint) point;
-(CGPoint) closestGate: (CGPoint) point;

-(void) startGame:(id) sender;
-(void) restartGame:(id) sender;
-(void) goHome:(id) sender;
-(void) clearLines:(id) sender;
-(void) previousLine:(id) sender;
-(void) buildGame:(NSDictionary *) nextLevel;

@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
