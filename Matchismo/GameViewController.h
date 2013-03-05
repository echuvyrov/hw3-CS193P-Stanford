//
//  GameViewController.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/19/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "MatchingGame.h"

@interface GameViewController : UIViewController

// all of the following methods must be overriden by concrete subclasses
- (Deck *)createDeck; // abstract
@property (readonly, nonatomic) NSUInteger startingCardCount; // abstract
@property (strong, nonatomic) MatchingGame *game; // abstract

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract

@end
