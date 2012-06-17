//
//  MasterViewController.m
//  ScaryBugs
//
//  Created by Ray Wenderlich on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "DetailViewController.h"

@implementation MasterViewController
@synthesize bugs = _bugs;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Scary Bugs";
    // for leftBarButtonItem, use a built in button called editButtonItem
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // use UIBarButtonSystemItemAdd and designate addTapped to be called
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete from our data table
        [_bugs removeObjectAtIndex:indexPath.row];
        // delete from table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        /*
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         */
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.bugs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    ScaryBugDoc *bug = [self.bugs objectAtIndex:indexPath.row];
    cell.textLabel.text = bug.data.title;
    cell.imageView.image = bug.thumbImage;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailController =segue.destinationViewController;
    ScaryBugDoc *bug = [self.bugs objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailController.detailItem = bug;
}

- (void)addTapped:(id)sender {
    // make a scaryDoc with some default values and add to our bug list
    ScaryBugDoc *newDoc = [[ScaryBugDoc alloc] initWithTitle:@"New Bug" rating:0 thumbImage:nil fullImage:nil];
    [_bugs addObject:newDoc];
    
    // make the indexPath etc point to new bug
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    
    // behave as if the user had clicked on it
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewRowAnimationMiddle];
    [self performSegueWithIdentifier:@"MySegue" sender:self];
}
@end
