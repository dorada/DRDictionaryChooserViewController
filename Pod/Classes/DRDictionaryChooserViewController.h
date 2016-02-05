//
//  DictionaryChooserViewController.h
//
//  Created by Daniel Broad on 15/07/2010.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRDictionaryChooserViewController;

@protocol DRDictionaryChooserDelegate <NSObject>
-(void) dictionaryChooser: (DRDictionaryChooserViewController*) sender didSelectKey: (NSString*) selectedKey;
@end

@interface DRDictionaryChooserViewController : UITableViewController

@property (nonatomic) NSArray *optionsToChoose;
@property (nonatomic) NSArray *keys;
@property (nonatomic) NSString *selectedKey;
@property (nonatomic) NSString *footer;
@property (nonatomic) NSString *customHeading;
#if __IPHONE_OS_VERSION_MIN_ALLOWED < __IPHONE_5_0
@property (nonatomic,assign) id<DRDictionaryChooserDelegate> delegate;
#else
@property (nonatomic,weak) id<DRDictionaryChooserDelegate> delegate;
#endif
@property NSInteger tag;

+(void) showSelection: (NSArray*) values keys:(NSArray*) keys withSelectedItem: (NSString*) key andTag: (NSInteger) tag andTitle: (NSString*) title andFooterText: (NSString*) footer andCustomHeading: (NSString*) customHeading fromViewController: (UIViewController*) vc;

// subclasses can override
-(void) themeCell: (UITableViewCell*) cell;
-(Class) TextFieldClass;

@end
