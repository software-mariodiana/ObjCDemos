//
//  ViewController.m
//  SearchControllerDemo
//
//  Created by Mario Diana on 9/13/20.
//  Copyright © 2020 Mario Diana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UISearchControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* fruits;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fruits = @[@"Apple", @"Banana", @"Mango", @"Pear", @"Watermelon"];
    
    UISearchController* searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.delegate = self;
    searchController.searchBar.placeholder = @"Fruits";
    self.navigationItem.searchController = searchController;
}

#pragma mark - Search controller

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    NSLog(@"## Search controller: %@", searchController);
}

#pragma mark - Table view datasource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self fruits] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FruitCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"FruitCell"];
    }
    
    cell.textLabel.text = [[self fruits] objectAtIndex:[indexPath row]];
    
    return cell;
}

@end
