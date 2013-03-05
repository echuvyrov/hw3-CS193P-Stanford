//
//  SetCardView.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 3/1/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger shapeCount;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) UIColor *shapeColor;
@property (nonatomic) CGFloat shapeShade;

@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
