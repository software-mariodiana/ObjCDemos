//
//  ViewController.m
//  SearchControllerDemo
//
//  Created by Mario Diana on 9/13/20.
//  Copyright © 2020 Mario Diana. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* fruits;
@property (nonatomic, strong) NSPredicate* filter;
@property (nonatomic, strong) NSArray* tableData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fruits = @[@"Apple", @"Banana", @"Mango", @"Pear", @"Watermelon"];
    self.tableData = self.fruits;
    
    UISearchController* searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.delegate = self;
    self.navigationItem.searchController = searchController;
    
    searchController.searchBar.placeholder = @"Search fruits";
    searchController.searchBar.delegate = self;
    
    // iOS docs: If you use the same view controller to display the searchable content
    // and search results, it is recommended that you set this property to NO.
    searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.title = @"Fruits";
    
    self.filter = [NSPredicate predicateWithBlock:^BOOL(NSString* fruit, NSDictionary* bindings) {
        if ([[[self searchBar] text] length] > 0) {
            // Case-insensitive match of any substring found.
            return [[fruit lowercaseString] containsString:[[[self searchBar] text] lowercaseString]];
        }
        else {
            return fruit;
        }
    }];
}

- (UISearchBar *)searchBar
{
    return [[[self navigationItem] searchController] searchBar];
}

- (void)updateTableData
{
    self.tableData = [[self fruits] filteredArrayUsingPredicate:[self filter]];
    [[self tableView] reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[self tableView] deselectRowAtIndexPath:[[self tableView] indexPathForCell:sender] animated:NO];
    DetailViewController* dvc = [segue destinationViewController];
    
    // Remember, at this point in the segue no widgets have been instantiated
    // in the destination view controller!
    [dvc setFruitName:[[sender textLabel] text]];
}

#pragma mark - Search controller & search bar delegate methods

- (void)didDismissSearchController:(UISearchController *)searchController
{
    [self updateTableData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateTableData];
}

#pragma mark - Table view datasource methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self tableData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseIdentifier"];
    cell.textLabel.text = [[self tableData] objectAtIndex:[indexPath row]];
    return cell;
}

@end
