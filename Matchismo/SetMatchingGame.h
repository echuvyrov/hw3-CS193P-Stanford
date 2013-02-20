//
//  SetMatchingGame.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SetMatchingGame : NSObject

//Designated Initializer
-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck;

-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*) cardAtIndex:(NSUInteger) index;

@property(nonatomic) int simultaneousCardsMatch;
@property(nonatomic, readonly) int score;
@property(nonatomic, readonly) NSString* lastAction;

@end
