/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 * Author: Timothy Luong
 */

#import "MenuLayer.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "FinishedLevelLayer.h"

int leveltag = 0;
@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

@synthesize helloWorldString, helloWorldFontName;
@synthesize helloWorldFontSize;


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
        
        start = [NSDate date];
        
        timeLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%f", 0.00] fontName:@"Futura-CondensedExtraBold" fontSize:14];
        timeLabel.position = ccp(300, 450);
        timeLabel.color = ccGREEN;
        [self addChild: timeLabel];
        
        test = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"Level%i.plist", leveltag]];
        leveltag = [[test objectForKey:@"LevelTag"] intValue];
        
        [self buildGame:test];
        
        
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level%i", leveltag] fontName:@"Futura-CondensedExtraBold" fontSize:35];
        //label.position = [CCDirector sharedDirector].screenCenter;
        label.position = ccp(160, 450);
        label.color =ccGREEN;
        [self addChild:label];
        
        startButton = [CCMenuItemImage itemFromNormalImage:@"go.png" selectedImage:@"goselect.png" target:self selector:@selector(startGame:)];
        startButton.position = ccp(160, 415);
        tempMenu = [CCMenu menuWithItems:startButton, nil];
        tempMenu.position = CGPointZero;
        [self addChild:tempMenu];
        
        restartButton = [CCMenuItemImage itemFromNormalImage:@"Restart.png" selectedImage:@"RestartClicked.png" target:self selector:@selector(restartGame:)];
        restartButton.position = ccp(80, 40);
        
        clearButton = [CCMenuItemImage itemFromNormalImage:@"Clear.png" selectedImage:@"ClearClicked.png" target:self selector:@selector(clearLines:)];
        clearButton.position = ccp(240, 40);
        
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
    leveltag = i;
    CCScene* myScene = [HelloWorldLayer scene];
    return myScene;
}

+(id) scene
{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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

}

-(void) clearLines: (CCMenuItem *) menuItem
{
    //If i made temp inside the forloop, it would decrease while the forloop proceeded
    int temp = [startpoints count];
    
    for(int k = 0; k< temp - (int)[startlines count]; k++)
    {
        [startpoints removeLastObject];
        [endpoints removeLastObject];
        [points removeLastObject];
        [points removeLastObject];
    }
}

-(void) previousLine: (CCMenuItem *) menuItem
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

-(void) draw
{
    //enable an opengl setting to smooth the line once it is drawn
    glEnable(GL_LINE_SMOOTH);
    
    //set the color in RGB to draw the line with
    glColor4ub(255,0,255,255);
    
    //import plist 
    vertlines = [test objectForKey:@"VerticalLines"];
    
    for(int k = 0; k<(int)[vertlines count] ; k++)
    {
        item = [vertlines objectAtIndex:k];
        x = [item objectForKey:@"x1"];
        x2 = [item objectForKey:@"x2"];
        y = [item objectForKey:@"y1"];
        y2 = [item objectForKey:@"y2"];
        CGPoint a = ccp([x floatValue],  [y floatValue]);
        CGPoint b = ccp([x2 floatValue], [y2 floatValue]);
        ccDrawLine(a, b);
    }

    KKInput *input = [KKInput sharedInput];
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
        float y2 = y1;
        if (test1 < 30)
        {
            blah =ccp(40, y2);
        }
        else
        {
            if (test2 < 30)
            {
                blah =ccp(100, y2);
            }
            else
            {
                if (test3 < 30)
                {
                    blah =ccp(160, y2);
                }
                else 
                {
                    if (test4 < 30)
                    {
                        blah =ccp(220, y2);
                    }
                    else
                    {
                            blah =ccp(280, y2);
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
    //Draw all the lines
    for (int k = 0; k<(int)[endpoints count]; k++) 
    {
        CGPoint start = CGPointFromString([startpoints objectAtIndex:k]);
        CGPoint end = CGPointFromString([endpoints objectAtIndex:k]); 
        CGPointMake(start.x, start.y);
        CGPointMake(end.x, end.y);
        ccDrawLine(start, end);
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
            
        //Go through the teleporters
        CCSprite *tempTeleporter1 = [teleporters objectAtIndex:0];
        CCSprite *tempTeleporter2 = [teleporters objectAtIndex:1];
        
        if (CGPointEqualToPoint(temp.position, tempTeleporter1.position))
            {
                CGPoint destination = tempTeleporter2.position;
                temp.position = destination;
                CGPoint velocity = CGPointMake(0, -1);
                temp.position = ccpAdd(temp.position, velocity);
            }
            
            else if (CGPointEqualToPoint(temp.position, tempTeleporter2.position))
                     {
                         CGPoint destination = tempTeleporter1.position;
                         temp.position = destination;
                         CGPoint velocity = CGPointMake(0, -1);
                         temp.position = ccpAdd(temp.position, velocity);
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
            /*
            if ([self smallestDistanceFromPoint:blah]<1.0)
            {
                temp.position = [self closestPoint:blah];
            }
            
            else if ([self smallestDistanceFromGate:blah]<1.0)
            {
                temp.position = [self closestGate:blah];
            }
            
            else if ([self smallestDistanceFromTeleporter:blah]<1.0)
            {
                CCSprite *tempTeleporter1 = [teleporters objectAtIndex:0];
                CCSprite *tempTeleporter2 = [teleporters objectAtIndex:1];
                
                if (ccpDistance(blah, tempTeleporter1.position)<ccpDistance(blah, tempTeleporter2.position))
                {
                    temp.position = tempTeleporter1.position;
                }
                else
                {
                    temp.position = tempTeleporter2.position;
                }
            }
            */
            //else
            //{
                CGPoint velocity = CGPointMake(0, -1);
                temp.position = ccpAdd(temp.position, velocity);
            //}
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
            
            leveltag++;
             CCScene *scene = [CCScene node];
             [scene addChild:[HelloWorldLayer node]];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:1 scene: [HelloWorldLayer showLevel:leveltag]]];
            //[[CCDirector sharedDirector] replaceScene:[FinishedLevelLayer showLevel:leveltag]];
             
        

        }
        else
        {winCounter = 0;}
        
    }
        timeInterval = [start timeIntervalSinceNow];
        time = [NSNumber numberWithDouble:fabs(timeInterval)];
        [timeLabel setString:[NSString stringWithFormat:@"%.2f", [time floatValue]]];
}
 
@end
