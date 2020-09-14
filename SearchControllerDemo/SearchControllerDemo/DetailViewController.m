//
//  DetailViewController.m
//  SearchControllerDemo
//
//  Created by Mario Diana on 9/13/20.
//  Copyright © 2020 Mario Diana. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (copy, nonatomic) NSString* fruitName;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.text = self.fruitName;
}

- (void)setFruitName:(NSString *)fruitName
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    self.label.text = fruitName;
    _fruitName = fruitName;
    
}

@end
