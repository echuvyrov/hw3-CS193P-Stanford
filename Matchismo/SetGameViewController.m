//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetMatchingGame.h"

@interface SetGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setGameCards;

@property (nonatomic) int flipCount;
@property (nonatomic, strong)Card *card;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) SetMatchingGame *game;

- (IBAction)dealAction:(id)sender;

@end

@implementation SetGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dealAction:(id)sender {
    [self startNewGame];

}

-(void) startNewGame{
    self.game = [[SetMatchingGame alloc] initWithCardCount:self.setGameCards.count usingDeck:[[SetCardDeck alloc] init]];
    [self updateUI];
    
    self.flipsCountLabel.text = @"Flips: 0";
    self.lastActionLabel.text = @"Last Action: shuffled the deck";
    self.scoreLabel.text = @"Score: 0";
    self.flipCount = 0;
}

-(void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"Icon.png"];
    for(UIButton *cardButton in self.setGameCards) {
        
        Card *card = [self.game cardAtIndex:[self.setGameCards indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable? 0.3 : 1.0;
        if(cardButton.isSelected){
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastActionLabel.text = self.game.lastAction;
}

@end
