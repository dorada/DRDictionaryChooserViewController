//
//  DRDictionaryChooserViewController.m
//
//  Created by Daniel Broad on 15/07/2010.
//  Copyright 2010. All rights reserved.
//

#import "DRDictionaryChooserViewController.h"

@interface DRDictionaryChooserViewController () <UITextFieldDelegate>
@end

@implementation DRDictionaryChooserViewController {
    UITextField *_textField;
}

+(void) showSelection: (NSArray*) values keys:(NSArray*) keys withSelectedItem: (NSString*) key andTag: (NSInteger) tag andTitle: (NSString*) title andFooterText: (NSString*) footer andCustomHeading: (NSString*) customHeading fromViewController: (UIViewController*) vc
{
    DRDictionaryChooserViewController *dictionaryController;
    dictionaryController = [[self alloc] init];
    dictionaryController.optionsToChoose = values;
    dictionaryController.keys = keys;
    dictionaryController.delegate = (id)vc;
    dictionaryController.selectedKey = key;
    dictionaryController.tag = tag;
    dictionaryController.title = title;
    dictionaryController.footer = footer;
    dictionaryController.customHeading = customHeading;
    [vc.navigationController pushViewController:dictionaryController animated:YES];
}


#pragma mark - View lifecycle

-(instancetype) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.title = self.title;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        [self processTextField];
    }
}
#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0 && !self.customHeading) {
        return self.footer;
    }
    if (section == 1 && self.customHeading) {
        return self.footer;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.customHeading;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (self.customHeading) {
        return 2;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return [_optionsToChoose count];
    }
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        NSString *theKey = [_keys objectAtIndex:indexPath.row];
        cell.textLabel.text = [_optionsToChoose objectAtIndex:indexPath.row];
        
        if (self.selectedKey && [theKey compare:self.selectedKey]==NSOrderedSame)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [self themeCell:cell];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    _textField = [[[self TextFieldClass] alloc] initWithFrame:CGRectInset(cell.contentView.bounds,cell.separatorInset.left,10)];
    _textField.delegate = self;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [cell.contentView addSubview:_textField];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.enablesReturnKeyAutomatically = YES;
    _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    if ([_keys indexOfObject:self.selectedKey]==NSNotFound) {
        _textField.text = self.selectedKey;
    }
    [self themeCell:cell];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        _textField.frame = CGRectInset(cell.contentView.bounds,cell.separatorInset.left,10);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *theKey = [_keys objectAtIndex:indexPath.row];
        self.selectedKey = theKey;
        if ([_delegate respondsToSelector:@selector(dictionaryChooser:didSelectKey:)]) {
            [_delegate dictionaryChooser:self didSelectKey:self.selectedKey];
        }
        [self.tableView reloadData];
        [self logSetting];
        _textField.text = nil;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [_textField becomeFirstResponder];
    }
}


#pragma mark - Methods

-(void) logSetting {
    if (!self.selectedKey) return;
    //NSDictionary *setting = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedKey,@"Selected Value",nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) textFieldShouldClear:(UITextField *)textField {
    dispatch_async(dispatch_get_main_queue(), ^{
        [textField resignFirstResponder];
    });
    return YES;
}

-(void) processTextField {
    if ([_textField.text length]) {
        self.selectedKey = _textField.text;
        if ([_delegate respondsToSelector:@selector(dictionaryChooser:didSelectKey:)]) {
            [_delegate dictionaryChooser:self didSelectKey:self.selectedKey];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self logSetting];
    }
}

-(void) textFieldChanged: (id) sender {
    
}

-(void) themeCell: (UITableViewCell*) cell {
    // subclasses do your thing
}

-(Class) TextFieldClass {
    return UITextField.class;
}

@end

