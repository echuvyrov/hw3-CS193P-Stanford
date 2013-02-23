//
//  SetCard.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;   // because we provide both setter & getter

-(int)match:(NSArray *) otherCards
{
    int score = 0;
    BOOL allShapesSameOrDifferent = FALSE;
    BOOL allColorsSameOrDifferent = FALSE;
    BOOL allShadesSameOrDifferent = FALSE;
    BOOL allCountsSameOrDifferent = FALSE;
    
    if(otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *thirdCard = [otherCards objectAtIndex:0];
        
        //3 elements must be all the same or they must all be different
        if([otherCard.shape isEqualToString:self.shape] && [thirdCard.shape isEqualToString:self.shape]){
            allShapesSameOrDifferent = TRUE;
        }
        if ([otherCard.shapeColor isEqual:self.shapeColor] && [thirdCard.shapeColor isEqual:self.shapeColor]) {
            allColorsSameOrDifferent = TRUE;
        }
        if (otherCard.shapeCount == self.shapeCount && thirdCard.shapeCount == self.shapeCount) {
            allCountsSameOrDifferent = TRUE;
        }
        if (otherCard.shapeShade == self.shapeShade && thirdCard.shapeShade == self.shapeShade) {
            allShadesSameOrDifferent = TRUE;
        }
        // now compare when all three are not equal
        if(![otherCard.shape isEqualToString:self.shape] && ![thirdCard.shape isEqualToString:self.shape] && ![thirdCard.shape isEqualToString:otherCard.shape]){
            allShapesSameOrDifferent = TRUE;
        }
        if (![otherCard.shapeColor isEqual:self.shapeColor] && ![thirdCard.shapeColor isEqual:self.shapeColor] && ![thirdCard.shapeColor isEqual:otherCard.shapeColor]) {
            allColorsSameOrDifferent = TRUE;
        }
        if (otherCard.shapeCount != self.shapeCount && thirdCard.shapeCount != self.shapeCount && thirdCard.shapeCount != otherCard.shapeCount) {
            allCountsSameOrDifferent = TRUE;
        }
        if (otherCard.shapeShade != self.shapeShade && thirdCard.shapeShade != self.shapeShade && thirdCard.shapeShade != otherCard.shapeShade) {
            allShadesSameOrDifferent = TRUE;
        }
        
        if(allColorsSameOrDifferent && allCountsSameOrDifferent && allShadesSameOrDifferent && allShapesSameOrDifferent) {
            score = 13;
        }
    }
    
    return score;
}

// Overriding the contents property from card class.
-(NSAttributedString *)contents
{
    //get initial shape and print it a number of times
    NSString *str = @"";
    for(int i= 0; i < self.shapeCount; i++)
    {
        str=[str stringByAppendingString:self.shape];
    }
    
    NSMutableAttributedString *retVal = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange(0, [retVal length]);
    
    [retVal addAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15],
        NSForegroundColorAttributeName : [self.shapeColor colorWithAlphaComponent:self.shapeShade],
        NSStrokeWidthAttributeName : @-5,
        NSStrokeColorAttributeName : self.shapeColor,
     } range:range];
    
    return retVal;
}

+ (NSArray *)validShapes
{
    return @[@"●", @"■", @"▲"];
}

+ (NSArray *)shapeColors
{
    return @[[UIColor redColor] , [UIColor greenColor], [UIColor purpleColor]];
}

+ (NSArray *)shapeShades
{
    return @[@0, @0.5, @1];
}

+ (NSArray *)shapeCounts
{
    return @[@1, @2, @3];
}

- (void)setShape:(NSString *)shape
{
    if([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

- (UIColor *)shapeColor
{
    return _shapeColor ? _shapeColor : [UIColor blackColor];
}

- (CGFloat)shapeShade
{
    return _shapeShade ? _shapeShade : 0.0f;
}

- (NSUInteger)shapeCount
{
    return _shapeCount? _shapeCount : 0;
}


@end
