//
//  DRViewController.m
//  DRDictionaryChooserViewController
//
//  Created by Daniel Broad on 02/05/2016.
//  Copyright (c) 2016 Daniel Broad. All rights reserved.
//

#import "DRViewController.h"

#import "DRDictionaryChooserViewController.h"

@interface DRViewController () <DRDictionaryChooserDelegate>

@end

@implementation DRViewController

-(NSArray*) impKeys {
    return @[@"100",@"500",@"600",@"800",@"1000",@"1250",@"1600",@"2000",@"3200",@"10000"];
}

-(NSArray*) impObjects {
    return @[@"100",@"500",@"600",@"800",@"1000",@"1250",@"1600",@"2000",@"3200",@"10000"];
}

-(IBAction)goChooser:(id)sender {
    [DRDictionaryChooserViewController showSelection:[self impObjects]
                                              keys:[self impKeys]
                                  withSelectedItem:[NSString stringWithFormat:@"%ld",(long)100]
                                            andTag:1
                                          andTitle:NSLocalizedString(@"Set impulses per kWh", nil)
                                     andFooterText:NSLocalizedString(@"This value will be written on your electricity meter", nil)
                                  andCustomHeading:nil
                                fromViewController:self];
}

-(void) dictionaryChooser: (DRDictionaryChooserViewController*) sender didSelectKey: (NSString*) selectedKey {
    NSLog(@"You chose %@",selectedKey);
}
@end
