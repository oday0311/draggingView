//
//  polygonView.m
//  DragReaction
//
//  Created by Alex on 15/7/7.
//  Copyright (c) 2015年 Zuse. All rights reserved.
//

#import "polygonView.h"
#import "JSONKit.h"
@implementation polygonView


- (void)drawRect:(CGRect)rect {

    
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(194.0, 83.0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(244.0, 83.0)];
    [aPath addLineToPoint:CGPointMake(214, 120)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    [aPath stroke];//Draws line 根据;
    [aPath fill];
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(243, 82.0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(263, 112.0)];
    [aPath addLineToPoint:CGPointMake(247, 133)];
    [aPath addLineToPoint:CGPointMake(216, 123)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    [aPath stroke];//Draws line 根据;
    [aPath fill];
    // Drawing code
    
    NSString* exampleString = @"[[[194,83,244,83,214,124],[243,82,263,112,247,133,216,123]],[[147,151,189,155,189,179,149,182],[188,154,211,148,212,176,188,178],[211,146,254,138,253,167,210,176],[217,174,251,167,243,190,219,191],[220,190,243,189,240,192,244,267,220,267],[219,265,244,266,242,366,212,365],[176,314,219,312,215,367]],[[101,214,130,212,131,240,102,240],[130,210,157,208,158,232,130,239],[156,207,207,197,212,223,158,230],[168,228,212,222,175,277,151,263,150,261],[150,261,175,276,103,337,89,313]],[[296,139,330,151,336,173,313,189,288,171],[288,170,314,188,264,220,250,224,252,208]],[[235,184,280,232,260,251,237,217],[279,232,315,263,287,284,260,249],[313,262,346,280,390,294,390,308,356,314,315,313,286,283]]]";
    
    
    NSArray * zitiArray = [exampleString objectFromJSONString];
    
    for(int k = 0;k<zitiArray.count ;k++)
    {
        NSArray* bihuaArray  = [zitiArray objectAtIndex:k];
        
        NSLog(@"the size of ziti is %d", bihuaArray.count);
        
        for (int i =0; i<bihuaArray.count; i++) {
            NSArray* polygonAreas = [bihuaArray objectAtIndex:i];
            
            float f1 = ((NSNumber*)[polygonAreas objectAtIndex:0]).floatValue;
            float f2 = ((NSNumber*)[polygonAreas objectAtIndex:1]).floatValue;
            [aPath moveToPoint:CGPointMake(f1, f2)];
            for (int j = 2; j<polygonAreas.count; j=j+2) {
                float temp1 = ((NSNumber*)[polygonAreas objectAtIndex:j]).floatValue;
                float temp2 = ((NSNumber*)[polygonAreas objectAtIndex:j+1]).floatValue;
                [aPath addLineToPoint:CGPointMake(temp1, temp2)];
            }
            
            [aPath stroke];//Draws line 根据;
            [aPath fill];
        }
    }
   
}








@end
