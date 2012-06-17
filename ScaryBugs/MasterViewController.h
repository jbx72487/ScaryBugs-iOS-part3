//
//  MasterViewController.h
//  ScaryBugs
//
//  Created by Ray Wenderlich on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

@property (strong) NSMutableArray *bugs;

@end

// never perform long-running operations on the thread - instead run them on a background thead, ideally while user can do other things
// if work is required to occur before user can continue (ex. loading the image picker, then you should display a loading inicator so user understands that pap is working
// all GUI processes should be done on main thread (this is why all GUI objects should be nonatomic