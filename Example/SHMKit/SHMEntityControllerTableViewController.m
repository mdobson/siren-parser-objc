//
//  SHMEntityControllerTableViewController.m
//  SHMKit
//
//  Created by Matthew Dobson on 10/4/14.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import "SHMEntityControllerTableViewController.h"

@interface SHMEntityControllerTableViewController ()

@end

@implementation SHMEntityControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    switch (section) {
        case 0:
            sectionName = @"class";
            break;
        case 1:
            sectionName = @"properties";
            break;
        case 2:
            sectionName = @"entities";
            break;
        case 3:
            sectionName = @"actions";
            break;
        case 4:
            sectionName = @"links";
            break;
        default:
            break;
    }
    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger rows = 0;
    
    switch (section) {
        case 0:
            rows = self.entity.class.count;
            break;
        case 1:
            rows = self.entity.properties.count;
            break;
        case 2:
            rows = self.entity.entities.count;
            break;
        case 3:
            rows = self.entity.actions.count;
            break;
        case 4:
            rows = self.entity.links.count;
            break;
            
        default:
            break;
    }
    
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    

    cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                               green:153./255.
                                                blue:204./255.
                                               alpha:1.0];
    NSDictionary *descriptions = [self retrieveDescriptionForIndexPath:indexPath];
    cell.textLabel.text = descriptions[@"major"];
    cell.detailTextLabel.text = descriptions[@"minor"];
    return cell;
}

- (NSDictionary *) retrieveDescriptionForIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *descriptions;
    switch (indexPath.section) {
        case 0:
            descriptions = @{@"major": self.entity.class[indexPath.row], @"minor": @"class"};
            break;
        case 1:
            descriptions = @{@"major": self.entity.properties[self.entity.properties.allKeys[indexPath.row]], @"minor": self.entity.properties.allKeys[indexPath.row]};
            break;
        case 2:
            descriptions = [self entityDescription:self.entity.entities[indexPath.row]];
            break;
        case 3:
            descriptions = [self actionDescription:self.entity.actions[indexPath.row]];
            break;
        case 4:
            descriptions = [self linkDescription:self.entity.links[indexPath.row]];
            break;
        default:
            break;
    }
    return descriptions;
}

- (NSDictionary *) entityDescription:(SHMEntity *)entity {
    NSString *major = @"Entity Description Unavailable";
    NSString *minor = @"...";
    if (entity.properties != nil) {
        NSString *name = [entity.properties valueForKey:@"name"];
        NSString *ident = [entity.properties valueForKey:@"id"];
        if (name != nil) {
            major = name;
        } else if (ident != nil) {
            major = ident;
        }
            
    }
    
    if (entity.class != nil) {
        minor = entity.class[0];
    }
    
    return @{@"major": major, @"minor": minor};
}

- (NSDictionary *) actionDescription:(SHMAction *)action {
    NSString *major = @"Action Description Unavailable";
    NSString *minor = @"...";
    if (action.title != nil) {
        major = action.title;
    }
    
    if (action.href != nil) {
        minor = action.href;
    }
    
    return @{@"major": major, @"minor": minor};
}

- (NSDictionary *)linkDescription:(SHMLink *)link {
    NSString *major = link.title != nil ? link.title : link.rel[0];
    NSString *minor = link.href;
    return @{@"major": major, @"minor": minor};
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
