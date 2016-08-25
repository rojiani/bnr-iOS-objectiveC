//
//  ViewController.m
//  Quiz
//
//  Created by Michael Ward on 10/17/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic) IBOutlet UILabel *answerLabel;
@property (nonatomic) NSArray *questions;
@property (nonatomic) NSArray *answers;
@property (nonatomic) int currentQuestionIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.questions = @[ @"What is your name?",
                        @"What is your quest?",
                        @"What is your favorite color?" ];
    
    self.answers = @[ @"Sir Galahad of Camelot",
                      @"I seek the Grail",
                      @"Blue. No, yel-" ];
    
    self.questionLabel.text = self.questions[self.currentQuestionIndex];
}

- (IBAction)showNextQuestion:(id)sender {
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == self.questions.count) {
        self.currentQuestionIndex = 0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
}

@end
