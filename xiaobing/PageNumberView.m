//
//  PageNumberView.m
//  Info
//
//  Created by 张 玺 on 13-3-26.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "PageNumberView.h"

@implementation PageNumberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];

        //init title label
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        //init value=0
        self.value = 0;
        
        

    }
    return self;
}



-(void)setValue:(float)theValue
{
    _value = theValue;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [kColor_NavBgAlpha setFill];
    [kColor_NavBgAlpha setStroke];
    
    [self drawCircle:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2)];
    [self drawPanel];
    
    [[UIColor blackColor] setFill];

    [self drawCircle:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];

}
-(void)drawCircle:(CGRect)rect
{
    //添加中间的白圈
    CGContextRef     context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [self pathWithFrame:rect radius:rect.size.width/2]);
    CGContextDrawPath(context,kCGPathFillStroke);
    
}

-(void)drawPanel
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    //CGContextClearRect(context, self.bounds);
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center.x, center.y);
    
    CGPathAddArc(pathRef,
                 &CGAffineTransformIdentity,
                 center.x,
                 center.y,
                 center.x-1,
                 -PI/2,
                 self.value*2*PI-PI/2,
                 NO);
    
    CGPathCloseSubpath(pathRef);
    
    
    [kColor_NavBg setFill];
    //[RGB(95, 175, 234) setStroke];
    
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context,kCGPathFillStroke);
    
    CGPathRelease(pathRef);
}

//draw tools
-(CGMutablePathRef)pathWithFrame:(CGRect)frame radius:(float)radius
{
    CGPoint x1,x2,x3,x4; //x为4个顶点
    CGPoint y1,y2,y3,y4,y5,y6,y7,y8; //y为4个控制点
    //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
    x1 = frame.origin;
    x2 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y);
    x3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height);
    x4 = CGPointMake(frame.origin.x                 , frame.origin.y+frame.size.height);
    y1 = CGPointMake(frame.origin.x+radius          , frame.origin.y);
    y2 = CGPointMake(frame.origin.x+frame.size.width-radius, frame.origin.y);
    y3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+radius);
    y4 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height-radius);
    y5 = CGPointMake(frame.origin.x+frame.size.width-radius, frame.origin.y+frame.size.height);
    y6 = CGPointMake(frame.origin.x+radius, frame.origin.y+frame.size.height);
    y7 = CGPointMake(frame.origin.x, frame.origin.y+frame.size.height-radius);
    y8 = CGPointMake(frame.origin.x, frame.origin.y+radius);
    CGMutablePathRef pathRef = CGPathCreateMutable();
    if (radius<=0) {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, x1.x,x1.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x2.x,x2.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x3.x,x3.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x4.x,x4.y);
    }else
    {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, y1.x,y1.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y2.x,y2.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x2.x,x2.y,y3.x,y3.y,radius);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y4.x,y4.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x3.x,x3.y,y5.x,y5.y,radius);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y6.x,y6.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x4.x,x4.y,y7.x,y7.y,radius);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y8.x,y8.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x1.x,x1.y,y1.x,y1.y,radius);
    }
    CGPathCloseSubpath(pathRef);

    return pathRef;
}

@end
