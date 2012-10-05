//
//  BeginnerHelloWorldLayer.m
//  Criss Cross
//
//  Created by Timothy on 9/28/12.
//
//

#import "BeginnerHelloWorldLayer.h"
#import "MenuLayer.h"
#import "SimpleAudioEngine.h"
#import "BeginnerFinishedLevelLayer.h"
#import "HelloWorldLayer.h"
#define d(p1x, p1y, p2x, p2y) sqrt((p1x - p2x) * (p1x - p2x) + (p1y - p2y) * (p1y - p2y))


int beginnerleveltag = 0;
@interface BeginnerHelloWorldLayer (PrivateMethods)
@end

@implementation BeginnerHelloWorldLayer


-(id) init
{
    counter = 0;
    startCounter = 0;
    winCounter = 0;
    yellowlength = 0;
    redlength = 0;
    bluelength = 0;
    pinklength = 0;
    greenlength = 0;
    
    if ((self = [super init]))
    {
        background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(160, 240);
        [self addChild: background];
        
        //Add the Sprite Batch AFDSLKHLAKDFSHLAKDSFHLKASDFHASLDKFH
        batch = [CCSpriteBatchNode batchNodeWithFile:@"Line.png"];
        [self addChild:batch];
        
        test = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"BeginnerLevel%i.plist", beginnerleveltag]];
        beginnerleveltag = [[test objectForKey:@"LevelTag"] intValue];
        
        [self buildGame:test];
        
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"BeginnerLevel%i", beginnerleveltag] fontName:@"Futura-CondensedExtraBold" fontSize:35];
        //label.position = [CCDirector sharedDirector].screenCenter;
        label.position = ccp(160, 450);
        label.color =ccGREEN;
        [self addChild:label];
        
        startButton = [CCMenuItemImage itemFromNormalImage:@"start.png" selectedImage:@"startselect.png" target:self selector:@selector(startGame:)];
        startButton.position = ccp(160, 415);
        tempMenu = [CCMenu menuWithItems:startButton, nil];
        tempMenu.position = CGPointZero;
        [self addChild:tempMenu];
        
        restartButton = [CCMenuItemImage itemFromNormalImage:@"Restart.png" selectedImage:@"RestartClicked.png" target:self selector:@selector(restartGame:)];
        restartButton.position = ccp(70, 40);
        
        clearButton = [CCMenuItemImage itemFromNormalImage:@"ClearButton.png" selectedImage:@"ClearButtonClicked.png" target:self selector:@selector(clearLines:)];
        clearButton.position = ccp(250, 40);
        
        previousButton = [CCMenuItemImage itemFromNormalImage:@"previous.png" selectedImage:@"previousselect.png" target:self selector:@selector(previousLine:)];
        previousButton.position = ccp(135, 42);
        
        homeButton = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebuttonselect.png" target:self selector:@selector(goHome:)];
        homeButton.position = ccp(180, 40);
        
        [tempMenu addChild:restartButton];
        [tempMenu addChild:clearButton];
        [tempMenu addChild:previousButton];
        [tempMenu addChild:homeButton];
        
        [self scheduleUpdate];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Pow.caf"];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"beat.mp3"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"beat.mp3" loop:TRUE];
	}
	return self;
}

+(id) showLevel: (int) i
{
    beginnerleveltag = i;
    CCScene* myScene = [BeginnerHelloWorldLayer scene];
    return myScene;
}

+(id) scene
{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BeginnerHelloWorldLayer *layer = [BeginnerHelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) changeLength: (float)length color: (int)k destination:(CGPoint)temp
{
    if (k == 5)
    { yellowlength = length; yellowdestination = temp;}
    if (k == 6)
    { redlength = length; reddestination = temp;}
    if (k == 7)
    { bluelength = length; bluedestination = temp;}
    if (k == 8)
    { pinklength = length; pinkdestination = temp;}
    if (k == 9)
    { greenlength = length; greendestination = temp;}
}

-(void) subtractLength:(float)difference color:(int)k
{
    if (k == 5)
    { yellowlength = yellowlength - difference;}
    if (k == 6)
    { redlength = redlength - difference;}
    if (k == 7)
    { bluelength = bluelength - difference;}
    if (k == 8)
    { pinklength = pinklength - difference;}
    if (k == 9)
    { greenlength = greenlength - difference;}
}

-(float) whichLength:(int)k
{
    if (k == 5)
    { return yellowlength;}
    if (k == 6)
    { return redlength;}
    if (k == 7)
    { return bluelength;}
    if (k == 8)
    { return pinklength;}
    if (k == 9)
    { return greenlength;}
}

-(void) deleteLength:(int)k
{
    if (k == 5)
    { yellowlength = 0;}
    if (k == 6)
    { redlength = 0;}
    if (k == 7)
    { bluelength = 0;}
    if (k == 8)
    { pinklength = 0;}
    if (k == 9)
    { greenlength = 0;}
}
-(CGPoint) whichDestination:(int)k
{
    if (k == 5)
    { return yellowdestination;}
    if (k == 6)
    { return reddestination;}
    if (k == 7)
    { return bluedestination;}
    if (k == 8)
    { return pinkdestination;}
    if (k == 9)
    { return greendestination;}
}

-(float) smallestDistanceFromPoint:(CGPoint) point
{
    float temp = 100.0;
    
    //Go through all the points
    for (int j = 0; j<(int)[points count]; j++)
    {
        if (ccpDistance(CGPointFromString([points objectAtIndex:j]), point)<temp)
        {temp = ccpDistance(CGPointFromString([points objectAtIndex:j]), point);}
    }
    
    return temp;
}

-(CGPoint) closestPoint:(CGPoint) point
{
    float temp = 100.0;
    CGPoint tempPoint = ccp(0, 0);
    
    //Go through all the points
    for (int j = 0; j<(int)[points count]; j++)
    {
        if (ccpDistance(CGPointFromString([points objectAtIndex:j]), point)<temp)
        {
            temp = ccpDistance(CGPointFromString([points objectAtIndex:j]), point);
            tempPoint = CGPointFromString([points objectAtIndex:j]);
        }
    }
    
    return tempPoint;
    
}


-(float) smallestDistanceFromGate:(CGPoint) point
{
    float temp = 100.0;
    
    //Go through all the gates
    for (int k = 0; k<(int)[gate count]; k++)
    {
        CCSprite *tempSprite = [gate objectAtIndex:k];
        if (ccpDistance(tempSprite.position, point)<temp)
        {temp = ccpDistance(tempSprite.position, point);}
    }
    
    return temp;
}

-(CGPoint) closestGate:(CGPoint) point
{
    float temp = 100.0;
    CGPoint tempPoint = ccp(0, 0);
    
    //Go through all the gates
    for (int k = 0; k<(int)[gate count]; k++)
    {
        CCSprite *tempSprite = [gate objectAtIndex:k];
        if (ccpDistance(tempSprite.position, point)<temp)
        {
            temp = ccpDistance(tempSprite.position, point);
            tempPoint = tempSprite.position;
        }
    }
    
    return tempPoint;
}

-(float) smallestDistanceFromTeleporter:(CGPoint) point
{
    float temp = 100.0;
    
    //Go through all the teleporters
    for (int k = 0; k<(int)[teleporters count]; k++)
    {
        CCSprite *tempSprite2 = [teleporters objectAtIndex:k];
        if (ccpDistance(tempSprite2.position, point)<temp)
        {temp = ccpDistance(tempSprite2.position, point);}
    }
    return temp;
}

-(void) drawSprites:(CCSpriteBatchNode *)tempBatch point1:(CGPoint)p0 point2:(CGPoint)p1
{
    CCSprite *sprite = [CCSprite spriteWithBatchNode:tempBatch
                                                rect:CGRectMake(0, 0, d(p0.x, p0.y, p1.x, p1.y) + 2, 6)];
    sprite.position = ccp((p0.x + p1.x)/2, (p0.y + p1.y)/2);
    sprite.rotation = CC_RADIANS_TO_DEGREES(atan((p0.y - p1.y)/(p0.x - p1.x))) * -1;
    [tempBatch addChild:sprite];
}

-(void) buildGame:(NSDictionary *)nextLevel
{
    colored = [test objectForKey:@"Colors"];
    startlines = [test objectForKey:@"StartingLines"];
    gates = [test objectForKey:@"Gates"];
    teleporterArray = [test objectForKey:@"Teleporters"];
    
    startpoints = [[NSMutableArray alloc] init];
    endpoints = [[NSMutableArray alloc] init];
    points = [[NSMutableArray alloc] init];
    colors = [[NSMutableArray alloc] init];
    gate = [[NSMutableArray alloc] init];
    teleporters = [[NSMutableArray alloc] init];
    
    //Add the starting lines to the point arrays
    for (int k = 0; k<(int)[startlines count]; k++)
    {
        item = [startlines objectAtIndex:k];
        x = [item objectForKey:@"x1"];
        x2 = [item objectForKey:@"x2"];
        y = [item objectForKey:@"y1"];
        y2 = [item objectForKey:@"y2"];
        CGPoint a = ccp([x floatValue], [y floatValue]);
        CGPoint b = ccp([x2 floatValue], [y2 floatValue]);
        NSString *starter = NSStringFromCGPoint(a);
        NSString *ender = NSStringFromCGPoint(b);
        [startpoints addObject:starter];
        [endpoints addObject:ender];
        [points addObject:starter];
        [points addObject:ender];
        [self drawSprites:batch point1:a point2:b];
    }
    
    //import plist
    vertlines = [test objectForKey:@"VerticalLines"];
    //vertLineBatch = [CCSpriteBatchNode batchNodeWithFile:@"Line.png"];
    
    for(int k = 0; k<(int)[vertlines count] ; k++)
    {
        item = [vertlines objectAtIndex:k];
        x = [item objectForKey:@"x1"];
        x2 = [item objectForKey:@"x2"];
        y = [item objectForKey:@"y1"];
        y2 = [item objectForKey:@"y2"];
        CGPoint p0 = ccp([x floatValue],  [y floatValue]);
        CGPoint p1 = ccp([x2 floatValue], [y2 floatValue]);
        ccDrawLine(p0, p1);
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"VerticalLine.png"];
        int midy = ([y intValue] + [y2 intValue])/2;
        NSNumber *y3 = [NSNumber numberWithInt:midy];
        sprite.position = ccp([x floatValue], [y3 floatValue]);
        [self addChild:sprite];
    }
    
    //Make the colors
    for (int k = 0; k<(int)[colored count] ; k++)
    {
        item = [colored objectAtIndex:k];
        CCSprite *color = [CCSprite spriteWithFile:[item objectForKey:@"SpriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        color.position = ccp([x floatValue], [y floatValue]);
        
        NSNumber *tempTag = [item objectForKey:@"tag"];
        color.tag = [tempTag intValue];
        [colors addObject:color];
        [self addChild:color];
        
    }
    
    //Make the gates
    for (int k = 0; k<(int)[gates count] ; k++)
    {
        item = [gates objectAtIndex:k];
        CCSprite *tempGate = [CCSprite spriteWithFile:[item objectForKey:@"spriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        NSNumber *tempTag = [item objectForKey:@"tag"];
        tempGate.position = ccp([x floatValue], [y floatValue]);
        tempGate.tag = [tempTag intValue];
        [gate addObject:tempGate];
        [self addChild:tempGate];
    }
    
    //Make the teleporters
    for (int k = 0; k<(int)[teleporterArray count]; k++)
    {
        item = [teleporterArray objectAtIndex:k];
        CCSprite *tempTeleporter = [CCSprite spriteWithFile:[item objectForKey:@"spriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        tempTeleporter.position = ccp([x floatValue], [y floatValue]);
        [teleporters addObject:tempTeleporter];
        [self addChild:tempTeleporter];
    }
}

-(void) goHome:(CCMenuItem *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}

-(void) startGame: (CCMenuItem *) menuItem
{
    startCounter = 1;
}

-(void) restartGame: (CCMenuItem *) menuItem
{
    startCounter = 0;
    winCounter = 0;
    redlength = 0;
    bluelength = 0;
    yellowlength = 0;
    greenlength = 0;
    pinklength = 0;
    
    //Go through all the colors
    for (int k = 0; k<(int)[colors count]; k++)
    {
        [[colors objectAtIndex:k] removeFromParentAndCleanup:YES];
    }
    [colors removeAllObjects];
    
    for (int k = 0; k<(int)[colored count] ; k++)
    {
        item = [colored objectAtIndex:k];
        CCSprite *color = [CCSprite spriteWithFile:[item objectForKey:@"SpriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        color.position = ccp([x floatValue], [y floatValue]);
        
        NSNumber *tempTag = [item objectForKey:@"tag"];
        color.tag = [tempTag intValue];
        [colors addObject:color];
        [self addChild:color];
    }
    
    //Go through all the gates
    for (int k = 0; k<(int)[gate count]; k++)
    {
        [[gate objectAtIndex:k] removeFromParentAndCleanup:YES];
    }
    [gate removeAllObjects];
    
    //Make the gates
    for (int k = 0; k<(int)[gates count] ; k++)
    {
        item = [gates objectAtIndex:k];
        CCSprite *tempGate = [CCSprite spriteWithFile:[item objectForKey:@"spriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        NSNumber *tempTag = [item objectForKey:@"tag"];
        tempGate.position = ccp([x floatValue], [y floatValue]);
        tempGate.tag = [tempTag intValue];
        [gate addObject:tempGate];
        [self addChild:tempGate];
    }
    
    //Go through all the teleporters
    for (int k = 0; k<(int)[teleporters count] ; k++)
    {
        [[teleporters objectAtIndex:k] removeFromParentAndCleanup:YES];
    }
    [teleporters removeAllObjects];
    
    //Make the teleporters
    for (int k = 0; k<(int)[teleporterArray count]; k++)
    {
        item = [teleporterArray objectAtIndex:k];
        CCSprite *tempTeleporter = [CCSprite spriteWithFile:[item objectForKey:@"spriteName"]];
        x = [item objectForKey:@"x"];
        y = [item objectForKey:@"y"];
        tempTeleporter.position = ccp([x floatValue], [y floatValue]);
        [teleporters addObject:tempTeleporter];
        [self addChild:tempTeleporter];
    }
    
}

-(void) clearLines: (CCMenuItem *) menuItem
{
    if(startCounter==0)
    {
        //If i made temp inside the forloop, it would decrease while the forloop proceeded
        int temp = [endpoints count];
    
        if ([startpoints count] > [endpoints count])
        {
            [startpoints removeLastObject];
            [points removeLastObject];
            counter--;
            [self removeChild:target cleanup:YES];
        }
    
        for(int k = 0; k< temp - (int)[startlines count]; k++)
        {
            [startpoints removeLastObject];
            [endpoints removeLastObject];
            [points removeLastObject];
            [points removeLastObject];
            [batch removeChildAtIndex:[endpoints count] cleanup:YES];
        }
    }
}

-(void) previousLine: (CCMenuItem *) menuItem
{
    if(startCounter==0)
    {
        //Remove the previous drawn line, except for the original lines
        if ([startlines count] < [startpoints count])
        {
            if ([startpoints count] == [endpoints count])
            {
                [startpoints removeLastObject];
                [endpoints removeLastObject];
                [points removeLastObject];
                [points removeLastObject];
                [batch removeChildAtIndex:[endpoints count] cleanup:YES];
            }
            else
            {
                [startpoints removeLastObject];
                [points removeLastObject];
                counter--;
                [self removeChild:target cleanup:YES];
            }
        }
    }
}

-(void) update:(ccTime)delta
{
    if (startCounter >0)
    {
        
        if ([startpoints count] > [endpoints count])
        {
            [startpoints removeLastObject];
            [points removeLastObject];
            counter--;
            [self removeChild:target cleanup:YES];
        }
        
        //Go through all the colors.
        for (int k = 5; k<10; k++)
        {
            CCSprite *temp = (CCSprite *)[self getChildByTag:k];
            
            //Go through all the points
            for (int j = 0; j<(int)[points count]; j++)
            {
                
                //check if the position of one of the colors is the same as the position of one of the points
                if (CGPointEqualToPoint(temp.position, CGPointFromString([points objectAtIndex:j]))==YES)
                {
                    //check if the index of the point is even, so as to determine end or startpoint
                    if (j%2==0||j==0)
                    {
                        CGPoint destination = CGPointFromString([endpoints objectAtIndex:(j/2)]);
                        
                        float tempx = destination.x - temp.position.x;
                        float tempy = destination.y - temp.position.y;
                        float length = ccpDistance(temp.position, destination);
                        [self changeLength:length color:k destination:destination];
                        
                        
                        CGPoint velocity = CGPointMake((tempx/length), (tempy/length));
                        float subtractionLength = ccpDistance(temp.position, ccpAdd(temp.position,velocity));
                        temp.position = ccpAdd(temp.position, velocity);
                        [self subtractLength:subtractionLength color:k];
                    }
                    //if it's odd
                    else
                    {
                        CGPoint destination = CGPointFromString([startpoints objectAtIndex:(j/2)]);
                        
                        float tempx = destination.x - temp.position.x;
                        float tempy = destination.y - temp.position.y;
                        float length = ccpDistance(temp.position, destination);
                        [self changeLength:length color:k destination:destination];
                        
                        
                        CGPoint velocity = CGPointMake((tempx/length), (tempy/length));
                        float subtractionLength = ccpDistance(temp.position, ccpAdd(temp.position,velocity));
                        temp.position = ccpAdd(temp.position, velocity);
                        [self subtractLength:subtractionLength color:k];
                        
                    }
                }
                
            }
            
            //Check whether or not there are teleporters in the level
            if ([teleporters count]>0)
            {
                for (int k = 0; k<(int)[teleporters count]; k++)
                {
                    CCSprite *tempTeleporter = [teleporters objectAtIndex:k];
                    if (CGPointEqualToPoint(temp.position, tempTeleporter.position)&& k%2==0)
                    {
                        CCSprite *tempTeleporter2 = [teleporters objectAtIndex:k+1];
                        temp.position = tempTeleporter2.position;
                        CGPoint velocity = CGPointMake(0, -1);
                        temp.position = ccpAdd(temp.position, velocity);
                    }
                    else if (CGPointEqualToPoint(temp.position, tempTeleporter.position)&& k%2>0)
                    {
                        CCSprite *tempTeleporter2 = [teleporters objectAtIndex:k-1];
                        temp.position = tempTeleporter2.position;
                        CGPoint velocity = CGPointMake(0, -1);
                        temp.position = ccpAdd(temp.position, velocity);
                    }
                    
                }
            }
            
            //If the point is in the middle of transition, it will continue transitioning across
            if ([self whichLength:k]>0)
            {
                if ([self whichLength:k]<1)
                {
                    temp.position = [self whichDestination:k];
                    CGPoint velocity = CGPointMake(0, -1);
                    temp.position = ccpAdd(temp.position, velocity);
                    [self deleteLength:k];
                }
                else
                {
                    CGPoint destination = [self whichDestination:k];
                    
                    float tempx = destination.x - temp.position.x;
                    float tempy = destination.y - temp.position.y;
                    float length = ccpDistance(temp.position, destination);
                    
                    CGPoint velocity = CGPointMake((tempx/length), (tempy/length));
                    float subtractionLength = ccpDistance(temp.position, ccpAdd(temp.position,velocity));
                    temp.position = ccpAdd(temp.position, velocity);
                    [self subtractLength:subtractionLength color:k];
                }
            }
            
            //check if the color has reached the end of the line
            if (temp.position.y > 80 && [self whichLength:k] == 0)
            {
                CGPoint velocity = CGPointMake(0, -1);
                temp.position = ccpAdd(temp.position, velocity);
            }
        }
        
        //Go through the gates
        for (int j = 0; j<5; j++)
        {
            //Check to see if the gate exists
            if ([self getChildByTag:j] != NULL)
            {
                CCSprite *tempSprite = (CCSprite *)[self getChildByTag:j];
                CCSprite *tempColor = (CCSprite *)[self getChildByTag:(j+5)];
                if (CGPointEqualToPoint(tempSprite.position, tempColor.position))
                {
                    [self removeChild:tempSprite cleanup:YES];
                    [gate removeObject:tempSprite];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                }
            }
            
            //NSNotFound
        }
        
        //Check to see if the player has won
        for (int j = 0; j<5; j++)
        {
            CCSprite *tempColor = (CCSprite *)[self getChildByTag:(j+5)];
            CCSprite *tempBlur = (CCSprite *)[self getChildByTag:(j+10)];
            if (CGPointEqualToPoint(tempColor.position, tempBlur.position))
            {
                winCounter++;
            }
        }
        
        if (winCounter == 5 && [gate count] == 0)
        {
            startCounter = 0;
            winCounter = 0;
            
            beginnerleveltag++;
            [[CCDirector sharedDirector] replaceScene:[BeginnerFinishedLevelLayer showLevel:beginnerleveltag]];
            
        }
        else
        {winCounter = 0;}
        
    }
    
    else
    {
        if (startCounter == 0)
        {
            KKInput *input = [KKInput sharedInput];
            
            input.gestureSwipeEnabled = YES;
            
            if ([input gestureSwipeRecognizedThisFrame] && [startpoints count] == [endpoints count])
            {
                CGPoint clicked = [input gestureSwipeLocation];
                int x1 = (int) clicked.x;
                int test1 = abs(x1 - 40);
                int test2 = abs(x1 - 100);
                int test3 = abs(x1 - 160);
                int test4 = abs(x1 - 220);
                
                int y1 = (int) clicked.y;
                float y3 = y1;
                if (x1 < 40)
                {
                    blah = ccp(40, y3);
                }
                else
                    if (test1 < 30)
                    {
                        blah =ccp(40, y3);
                    }
                    else
                    {
                        if (test2 < 31)
                        {
                            blah =ccp(100, y3);
                        }
                        else
                        {
                            if (test3 < 30)
                            {
                                blah =ccp(160, y3);
                            }
                            else
                            {
                                if (test4 < 31)
                                {
                                    blah =ccp(220, y3);
                                }
                                else
                                {
                                    blah =ccp(280, y3);
                                }
                            }
                        }
                    }
                
                NSString *point = NSStringFromCGPoint(blah);
                if (blah.y>80 && blah.y<380 && [points indexOfObject:point]==NSNotFound && [self smallestDistanceFromPoint:blah]>1 && [self smallestDistanceFromGate:blah]>1 && [self smallestDistanceFromTeleporter:blah]>1)
                {
                    KKSwipeGestureDirection direction = [input gestureSwipeDirection];
                    if (direction == KKSwipeGestureDirectionLeft && (int)blah.x > 60)
                    {
                        blah2 = ccp(blah.x-60, blah.y);
                        NSString *point2 = NSStringFromCGPoint(blah2);
                        
                        if (blah2.y>80 && blah2.y<380 && [points indexOfObject:point2]==NSNotFound && [self smallestDistanceFromPoint:blah2]>1 && [self smallestDistanceFromGate:blah2]>1 && [self smallestDistanceFromTeleporter:blah2]>1)
                        {
                            [startpoints addObject:point];
                            [points addObject:point];
                            [endpoints addObject:point2];
                            [points addObject:point2];
                            
                            [self drawSprites:batch point1:blah point2:blah2];
                        }
                    }
                    else if (direction == KKSwipeGestureDirectionRight && (int)blah.x < 260)
                    {
                        blah2 = ccp(blah.x+60, blah.y);
                        NSString *point2 = NSStringFromCGPoint(blah2);
                        
                        if (blah2.y>80 && blah2.y<380 && [points indexOfObject:point2]==NSNotFound && [self smallestDistanceFromPoint:blah2]>1 && [self smallestDistanceFromGate:blah2]>1 && [self smallestDistanceFromTeleporter:blah2]>1)
                        {
                            [startpoints addObject:point];
                            [points addObject:point];
                            [endpoints addObject:point2];
                            [points addObject:point2];
                            
                            [self drawSprites:batch point1:blah point2:blah2];
                        }
                    }
                }
                
            }
            
            else
            {
                
                if ([input touchesAvailable])
                {
                    //Rounds the x value of the click to the nearest line
                    CGPoint clicked = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
                    int x1 = (int) clicked.x;
                    int test1 = abs(x1 - 40);
                    int test2 = abs(x1 - 100);
                    int test3 = abs(x1 - 160);
                    int test4 = abs(x1 - 220);
                    
                    int y1 = (int) clicked.y;
                    float y3 = y1;
                    
                    if(x1 < 40)
                    {
                        blah = ccp(40, y3);
                    }
                    else
                        if (test1 < 30)
                        {
                            blah =ccp(40, y3);
                        }
                        else
                        {
                            if (test2 < 31)
                            {
                                blah =ccp(100, y3);
                            }
                            else
                            {
                                if (test3 < 30)
                                {
                                    blah =ccp(160, y3);
                                }
                                else
                                {
                                    if (test4 < 31)
                                    {
                                        blah =ccp(220, y3);
                                    }
                                    else
                                    {
                                        blah =ccp(280, y3);
                                    }
                                }
                            }
                        }
                    
                    
                    NSString *point = NSStringFromCGPoint(blah);
                    if (blah.y>80 && blah.y<380 && [points indexOfObject:point]==NSNotFound && [self smallestDistanceFromPoint:blah]>1 && [self smallestDistanceFromGate:blah]>1 && [self smallestDistanceFromTeleporter:blah]>1)
                    {
                        if (counter == 0)
                        {
                            [startpoints addObject: point];
                            [points addObject: point];
                            counter++;
                            target = [CCSprite spriteWithFile:@"target.png"];
                            target.position = blah;
                            [self addChild:target];
                        }
                        else
                        {
                            
                            if (abs(
                                    (int)blah.x - CGPointFromString([startpoints objectAtIndex:[startpoints count]-1]).x)== 60 &&
                                abs(
                                    (int)blah.y - CGPointFromString([startpoints objectAtIndex:[startpoints count]-1]).y)< 51
                                )
                            {
                                [endpoints addObject: point];
                                [points addObject: point];
                                counter--;
                                [self removeChild:target cleanup:YES];
                                
                                CGPoint tempPoint = CGPointFromString([startpoints objectAtIndex:[startpoints count]-1]);
                                [self drawSprites:batch point1:tempPoint point2:blah];
                            }
                            else
                            {
                                [startpoints removeLastObject];
                                [points removeLastObject];
                                counter--;
                                [self removeChild:target cleanup:YES];
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}

@end
