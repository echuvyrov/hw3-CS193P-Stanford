//
//  SetCard.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize suit = _suit;   // because we provide both setter & getter

-(int)match:(NSArray *) otherCards
{
    int score = 0;
    if(otherCards.count == 1) {
        SetCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
        
    } else if (otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *thirdCard = [otherCards objectAtIndex:0];
        
        //try to match all 3
        if([otherCard.suit isEqualToString:self.suit] && [thirdCard.suit isEqualToString:self.suit]){
            score = 3;
        } else if (otherCard.rank == self.rank && thirdCard.rank == self.rank) {
            score = 12;
            //try to match at least two
            
        } else if ([otherCard.suit isEqualToString:self.suit] || [otherCard.suit isEqualToString:thirdCard.suit] || [self.suit isEqualToString:thirdCard.suit]){
            score = 1;
        } else if (otherCard.rank == self.rank || otherCard.rank == thirdCard.rank || thirdCard.suit == self.suit) {
            score = 2;
        }
    }
    
    return score;
}

// Overriding the contents property from card class.
-(NSString *)contents
{
    NSArray *rankStrings = [SetCard rankStrings];
    NSString* retVal = [rankStrings[self.rank] stringByAppendingString:self.suit];
    return retVal;
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
    @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [SetCard maxRank]) {    // needs to be <= to include kings
        _rank = rank;
    }
}


@end
