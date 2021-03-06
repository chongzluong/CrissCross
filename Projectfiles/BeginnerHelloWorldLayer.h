//
//  BeginnerHelloWorldLayer.h
//  Criss Cross
//
//  Created by Timothy on 9/28/12.
//
//

#import "CCLayer.h"

@interface BeginnerHelloWorldLayer : CCLayer
{
    CCSpriteBatchNode* vertLineBatch;
    CCSprite *background;
    CCSpriteBatchNode *batch;
    CCSprite *LevelNumber;
    CCSprite *electricLine;
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

-(void) drawSprites: (CCSpriteBatchNode*) tempBatch point1:(CGPoint)p0 point2:(CGPoint)p1;

-(CGPoint) closestPoint: (CGPoint) point;
-(CGPoint) closestGate: (CGPoint) point;

-(void) startGame:(id) sender;
-(void) restartGame:(id) sender;
-(void) goHome:(id) sender;
-(void) clearLines:(id) sender;
-(void) previousLine:(id) sender;
-(void) buildGame:(NSDictionary *) nextLevel;

@end

