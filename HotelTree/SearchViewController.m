//
//  ViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "SearchViewController.h"
#import "UserSearchResultViewController.h"
#import "RequirementViewController.h"

@interface SearchViewController ()<SearchMenuToSearchDelegate, QuantitySetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *checkInDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDisplayLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchContentTextField;

@property (nonatomic)double selectedLatitude;
@property (nonatomic)double selectedLongitude;
@property (weak, nonatomic) IBOutlet UILabel *roomQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *childrenQuatityLabel;

@end

@implementation ViewController

#pragma mark -Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Methods

- (IBAction)checkInDateButtonClicked {
}

- (IBAction)checkoutDateButtonClicked {
}
- (IBAction)textFieldBecomeResponder {
    [self performSegueWithIdentifier:@"toSearchMenuSegue" sender:nil];
}

#pragma mark - SearchMenuToSearchDelegate

- (void)updateSearchContent:(NSDictionary *)content withText:(NSString *)text{
    [self.searchContentTextField setText:text];
    self.selectedLatitude = [content[@"latitude"] doubleValue];
    self.selectedLongitude = [content[@"longitude"] doubleValue];
}

#pragma mark - QuantitySetDelegate

- (void)sendDataBack:(NSInteger)rooms adults: (NSInteger)adults children:(NSInteger)children{
    self.roomQuantityLabel.text = [NSString stringWithFormat:@"%lu", rooms];
    self.adultQuantityLabel.text = [NSString stringWithFormat:@"%lu", adults];
    self.childrenQuatityLabel.text = [NSString stringWithFormat:@"%lu",children];
}

@end
