//
//  ViewController.h
//  PDKTStickySectionHeadersCollectionViewLayoutDemo
//
//  Created by Daniel García on 31/12/13.
//  Copyright (c) 2013 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News : UIViewController {
    
    
    NSMutableArray *arr;
    int moduleNum;
    NSMutableArray *feedsArray;
    NSMutableArray *searchArray;
    BOOL searchActive;
    UIRefreshControl *refreshCtrl;
    UIImageView *noDataImg;
    UILabel *noDataLbl;
    
    NSMutableArray *speechArray;
    NSArray *speechArr;
    
    
    
    
}



@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSMutableArray *messagesArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong)  NSMutableArray *feedsArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong)UIRefreshControl *refreshCtrl;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *animateButton;
@property (nonatomic, retain) IBOutlet UISlider *progressSlider;
@property (nonatomic, retain) IBOutlet UISwitch *indeterminateSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *blurSwitch;
@property (nonatomic, retain) IBOutlet UISegmentedControl *statusPositionControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *maskTypeControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *superviewControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *iconControl;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property int moduleNum;

@property (nonatomic, retain) IBOutlet UISwitch *titleSwitch;
@property (nonatomic, retain) IBOutlet UIButton *finishButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;

- (IBAction)animateProgress:(id)sender;
- (IBAction)progressChanged:(id)sender;
- (IBAction)titleChanged:(id)sender;
- (IBAction)indeterminateChanged:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)cancel:(id)sender;





@end
