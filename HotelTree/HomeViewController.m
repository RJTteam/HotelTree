//
//  HomeViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableCell.h"
#import "RequirementViewController.h"
#import "UserSearchResultViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SearchMenuToSearchDelegate,QuantitySetDelegate, UITextFieldDelegate>
@property (strong,nonatomic) NSArray *homeArray;

@property (weak, nonatomic) IBOutlet UILabel *checkInDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDisplayLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchContentTextField;

@property (nonatomic)double selectedLatitude;
@property (nonatomic)double selectedLongitude;
@property (weak, nonatomic) IBOutlet UILabel *roomQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *childrenQuatityLabel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.fileManager fileExistsAtPath:self.diaryEntriesPath isDirectory:&isDirectory];
//    
//    if (isDirectory) {
//        NSString *dItemPath = [self.diaryEntriesPath stringByAppendingPathComponent:dItem.title];
//        
//        if ([self.fileManager fileExistsAtPath:dItemPath isDirectory:nil]) {
//            DiaryItem*rewriteDairy = [[DiaryItem alloc]init];
//            rewriteDairy.content = dItem.content;
//            NSData*data = [NSKeyedArchiver archivedDataWithRootObject:rewriteDairy];
//            [data writeToFile:dItemPath atomically:YES];
//        }
//        else{
//            //                [dItem.content writeToFile:dItemPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//            //
//            [self.filesOnDisk addObject:dItem.title];
//            DiaryItem*newDairy = [[DiaryItem alloc]init];
//            newDairy.title = dItem.title;
//            newDairy.content = dItem.content;
//            NSData*data = [NSKeyedArchiver archivedDataWithRootObject:newDairy];
//            [data writeToFile:dItemPath atomically:YES];
//            [self.delegate informationUpdated];
//        }
//    }
//    else{
//        NSLog(@"Directory notExist in the path: %@",self.diaryEntriesPath);
//    }
//    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
//    UIImage *image = [[UIImage alloc] initWithData:imgData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.searchContentTextField isFirstResponder]){
        [self.searchContentTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
#pragma mark - Event Methods

- (IBAction)checkInDateButtonClicked {
}

- (IBAction)checkoutDateButtonClicked {
}

- (IBAction)searchButtonClicked {
    BOOL searchResultEmpty = self.searchContentTextField.text.length == 0;
    BOOL checkInDateEmpty = self.checkInDisplayLabel.text.length == 0;
    BOOL checkOutDateEmpty = self.checkOutDisplayLabel.text.length == 0;
    BOOL requirementsEmpty = self.roomQuantityLabel.text.length == 0 && self.adultQuantityLabel.text.length == 0 && self.childrenQuatityLabel.text.length == 0;
    if(!searchResultEmpty && !checkInDateEmpty && !checkOutDateEmpty && !requirementsEmpty){
        //TODO send search information to prepare segue
        [self performSegueWithIdentifier:@"searchToListSegue" sender:nil];
    }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   [self performSegueWithIdentifier:@"toSearchMenuSegue" sender:nil];
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"searchToListSegue"]){
        //TODO perform search using ModelManager;
    }else if ([segue.identifier isEqualToString:@"toSearchMenuSegue"]){
        UserSearchResultViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if ([segue.identifier isEqualToString:@"toRequirementSetSegue"]){
        RequirementViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


@end
