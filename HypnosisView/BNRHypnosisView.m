//
//  BNRHypnosisView.m
//  HypnosisView
//
//  Created by test on 12/21/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

#import "BNRHypnosisView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface BNRHypnosisView ()
@end

@implementation BNRHypnosisView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    CGPoint center = self.center; //此center为全局坐标中的位置
    center.x -= self.frame.origin.x; //将center转化为局部坐标
    // float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height) / 2.0 ;
    
//    CGRect bounds = self.bounds;
//    CGPoint center;
//    center.x = bounds.origin.x + bounds.size.width / 2.0;
//    center.y = bounds.origin.y + bounds.size.height / 2.0;
    //NSLog(@"center: %f  %f",center.x,center.y);

    float maxRadius = hypot(rect.size.width, rect.size.height) / 2.0 ;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //[path addArcWithCenter:center radius:radius startAngle:0 endAngle:(2.0 * M_PI) clockwise:YES];
    
    while (maxRadius > 0) {
        [path moveToPoint:CGPointMake(center.x + maxRadius, center.y)];
        [path addArcWithCenter:center radius:maxRadius startAngle:0 endAngle:(2.0 * M_PI) clockwise:YES];
        maxRadius -= 20;
    }
    
    [self.circleColor setStroke];
    path.lineWidth = 10.0;
    [path stroke]; //画同心圆结束
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    UIBezierPath *pathTrangle = [[UIBezierPath alloc] init];
    [pathTrangle moveToPoint:CGPointMake(center.x, center.y - 200)]; //开始画三角形
    [pathTrangle addLineToPoint:CGPointMake(center.x - 100, center.y + 200)];
    [pathTrangle addLineToPoint:CGPointMake(center.x + 100, center.y + 200)];
    [pathTrangle closePath];
    
    [pathTrangle addClip];
    CGFloat locations[3] = {0.0,0.5,1.0};
    CGFloat components[12] = {1.0,0.0,0.0,1.0,
                            0.0,1.0,0.0,1.0,
                            0.0,0.0,1.0,1.0
    };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    CGPoint startPoint = CGPointMake(center.x - 100, center.y + 200);
    CGPoint endPoing = CGPointMake(center.x, center.y - 200);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoing, 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
//    [[UIColor greenColor] setFill];
//    [pathTrangle fill];
    CGContextRestoreGState(currentContext);//画三角形结束
    
    currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadowWithColor(currentContext, CGSizeMake(4, 7), 3,[[UIColor lightGrayColor] CGColor]);
    CGRect imageRect = CGRectMake(center.x - 25, center.y - 25, 50, 50);
    UIImage *image = [UIImage imageNamed:@"child-selected"];
    [image drawInRect:imageRect];
    CGContextRestoreGState(currentContext);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched",self);
    CGFloat red = arc4random() % 100 / 100.0;
    CGFloat green = arc4random() % 100 / 100.0;
    CGFloat blue = arc4random() % 100 / 100.0;
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = newColor;
}

-(void)setCircleColor:(UIColor *)mycircleColor
{
    _circleColor = mycircleColor;
    [self setNeedsDisplay];
}
@end
