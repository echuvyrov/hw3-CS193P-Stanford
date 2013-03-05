//
//  SetCardView.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 3/1/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetCardView.h"
#import <UIKit/UIKit.h>

@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation SetCardView
#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setShapeCount:(NSUInteger)shapeCount
{
    _shapeCount = shapeCount;
    [self setNeedsDisplay];
}

- (void)setShapeColor:(UIColor *)shapeColor
{
    _shapeColor = shapeColor;
    [self setNeedsDisplay];
}

- (void)setShapeShade:(CGFloat)shapeShade
{
    _shapeShade = shapeShade;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_RADIUS 12.0

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [self drawCardContents];
    
    [[UIColor clearColor] setFill];
    [roundedRect fill];
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

#define VIEW_HEIGHT 80.0
#define CORNER_OFFSET 2.0
#define SHAPE_HEIGHT 15.0
#define SHAPE_LENGTH 44.0
#define SHAPE_HALFLENGTH 22.0
#define SHAPE_HALFHEIGHT 10.0
#define SHAPE_OFFSET 15.0
#define BEZIER_SQUIGGLE_OFFSET 10.0

- (void)drawCardContents
{
    for(int i = 0; i<self.shapeCount; i++){
        if([self.shape isEqualToString:@"o"]) {
        
            //not pretty, but gets it done
            CGFloat x = SHAPE_OFFSET;
            CGFloat y;
            if(i==0 && self.shapeCount == 1){
                y = 35.0;
            }
            if(i==0 && self.shapeCount == 2){
                y = 25.0;
            }
            if(i==1 && self.shapeCount == 2){
                y = 45.0;
            }
            if(i==0 && self.shapeCount == 3){
                y = 15.0;
            }
            if(i==1 && self.shapeCount == 3){
                y = 35.0;
            }
            if(i==2 && self.shapeCount == 3){
                y = 55.0;
            }
            
            CGRect ovalContents = CGRectMake(x, y, SHAPE_LENGTH, SHAPE_HEIGHT);
            UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:ovalContents cornerRadius:CORNER_RADIUS];
            
            [roundedRect closePath];
            [self.shapeColor setFill];
            [roundedRect fillWithBlendMode:kCGBlendModeNormal alpha:self.shapeShade];
            [self.shapeColor setStroke];
            [roundedRect stroke];
            
        } else if ([self.shape isEqualToString:@"d"]) {
            CGFloat x = SHAPE_OFFSET;
            CGFloat y;
            if(i==0 && self.shapeCount == 1){
                y = 40.0;
            }
            if(i==0 && self.shapeCount == 2){
                y = 30.0;
            }
            if(i==1 && self.shapeCount == 2){
                y = 50.0;
            }
            if(i==0 && self.shapeCount == 3){
                y = 20.0;
            }
            if(i==1 && self.shapeCount == 3){
                y = 40.0;
            }
            if(i==2 && self.shapeCount == 3){
                y = 60.0;
            }
            
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:CGPointMake(x, y)];
            [path addLineToPoint:CGPointMake(x + SHAPE_HALFLENGTH, y + SHAPE_HALFHEIGHT)];
            [path addLineToPoint:CGPointMake(x + SHAPE_LENGTH, y)];
            [path addLineToPoint:CGPointMake(x + SHAPE_HALFLENGTH, y - SHAPE_HALFHEIGHT)];
            
            [path closePath];
            [self.shapeColor setFill];
            [path fillWithBlendMode:kCGBlendModeNormal alpha:self.shapeShade];
            [self.shapeColor setStroke];
            [path stroke];

        }
        else if ([self.shape isEqualToString:@"s"]) {

            CGFloat x = SHAPE_OFFSET;
            CGFloat y;
            if(i==0 && self.shapeCount == 1){
                y = 40.0;
            }
            if(i==0 && self.shapeCount == 2){
                y = 30.0;
            }
            if(i==1 && self.shapeCount == 2){
                y = 50.0;
            }
            if(i==0 && self.shapeCount == 3){
                y = 20.0;
            }
            if(i==1 && self.shapeCount == 3){
                y = 40.0;
            }
            if(i==2 && self.shapeCount == 3){
                y = 60.0;
            }
            
            UIBezierPath *curve = [UIBezierPath bezierPath];
            
            [curve moveToPoint:CGPointMake(x,y)];
            [curve addQuadCurveToPoint:CGPointMake(x + 10, y - 3)
                         controlPoint:CGPointMake(x + 3, y + 2)];
            [curve addCurveToPoint:CGPointMake(x + 20, y - 2)
                    controlPoint1:CGPointMake(x + 15, y - 5)
                    controlPoint2:CGPointMake(x + 18, y -3)];
            [curve addQuadCurveToPoint:CGPointMake(x + SHAPE_LENGTH, y - SHAPE_HALFHEIGHT)
                         controlPoint:CGPointMake(x + 30, y + 5)];
            
            curve.lineWidth = 10.0;
            [curve strokeWithBlendMode:kCGBlendModeNormal alpha:self.shapeShade];
            [self.shapeColor setStroke];
            [curve stroke];
        }
    }
}

#pragma mark - Gesture Handlers

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1;
    }
}

#pragma mark - Initialization

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}
@end
