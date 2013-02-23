//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetMatchingGame.h"

@interface SetMatchingGame()

@property(strong, nonatomic) NSMutableArray *cards;
@property(nonatomic) int score;
@property(nonatomic) NSMutableAttributedString* lastAction;

@end

@implementation SetMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck {
    
    self = [super init];
    if(self){
        for(int i=0; i < cardCount; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
    
}

-(Card*) cardAtIndex:(NSUInteger) index {
    return(index < self.cards.count) ? self.cards[index]:nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY_2CARDGAME 2
#define MATCH_BONUS_2CARDGAME 4
#define MISMATCH_PENALTY_3CARDGAME 4
#define MATCH_BONUS_3CARDGAME 16

-(void) flipCardAtIndex:(NSUInteger)index {
    
    Card* card = [self cardAtIndex:index];
    if(!card.isUnPlayable) {
        if(!card.isFaceUp) {
            
            self.lastAction = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"Flipped "]];
            [self.lastAction appendAttributedString:card.contents];
            
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnPlayable) {
                    
                    for(Card *thirdCard in self.cards) {
                        if(thirdCard.isFaceUp && !thirdCard.isUnPlayable && ![thirdCard.contents isEqualToAttributedString:otherCard.contents]) {
                            
                            //3-card matching logic
                            int matchScore = [card match:@[otherCard, thirdCard]];
                            if(matchScore){
                                thirdCard.unplayable = YES;
                                otherCard.unplayable = YES;
                                card.unplayable = YES;
                                self.score += matchScore;
                                
                                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                                [attrString appendAttributedString:card.contents];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                [attrString appendAttributedString:otherCard.contents];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" and "]];
                                [attrString appendAttributedString:thirdCard.contents];
                                NSString *scoreAddition = [NSString stringWithFormat:@" +%d points", matchScore];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:scoreAddition]];
                                
                                self.lastAction = attrString;
                            
                            
                            } else {
                                thirdCard.faceUp = NO;
                                otherCard.faceUp = NO;
                                card.faceUp = NO;
                                self.score -= MISMATCH_PENALTY_3CARDGAME;

                                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@""];
                                [attrString appendAttributedString:card.contents];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                [attrString appendAttributedString:otherCard.contents];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" and "]];
                                [attrString appendAttributedString:thirdCard.contents];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" do not match"]];
                                NSString *scoreDeduction = [NSString stringWithFormat:@" -%d points", MISMATCH_PENALTY_3CARDGAME];
                                [attrString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:scoreDeduction]];
                                
                                self.lastAction = attrString;
                                
                                return;
                            }
                        }
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
