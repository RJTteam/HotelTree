//
//  RequirementViewController.m
//  HotelTree
//
//  Created by Xinyuan Wang on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "RequirementViewController.h"
#import "FlatUIKit.h"
#import "UIImageView+GIF.h"

@interface RequirementViewController ()

@property( nonatomic)NSInteger roomsNumber;
@property( nonatomic)NSInteger adultNumber;
@property( nonatomic)NSInteger childNumber;

@property (weak, nonatomic) IBOutlet UILabel *adultLabel;
@property (weak, nonatomic) IBOutlet UILabel *childrenLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UIButton *plus1;
@property (weak, nonatomic) IBOutlet UIButton *plus2;
@property (weak, nonatomic) IBOutlet UIButton *plus3;

@property (weak, nonatomic) IBOutlet UIButton *minus1;
@property (weak, nonatomic) IBOutlet UIButton *minus2;
@property (weak, nonatomic) IBOutlet UIButton *minus3;


@end

@implementation RequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(applyButtonClicked:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = applyButton;
    //set labels
    self.adultNumber = 1;
    self.childNumber= 1;
    self.roomsNumber = 1;

    self.minus1.layer.cornerRadius = 15;
    self.minus2.layer.cornerRadius = 15;
    self.minus3.layer.cornerRadius = 15;

    self.plus1.layer.cornerRadius = 15;
    self.plus2.layer.cornerRadius = 15;
    self.plus3.layer.cornerRadius = 15;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Methods
- (IBAction)addButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.adultNumber += 1;
            self.adultLabel.text = [NSString stringWithFormat:@"%lu", self.adultNumber];
            break;
        case 2:
            self.childNumber += 1;
            self.childrenLabel.text = [NSString stringWithFormat:@"%lu", self.childNumber];
            break;
        case 3:
            self.roomsNumber += 1;
            self.roomLabel.text = [NSString stringWithFormat:@"%lu", self.roomsNumber];
            break;
        default:
            break;
    }
}

- (IBAction)subButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            if(self.adultNumber > 0){
                self.adultNumber -= 1;
                self.adultLabel.text = [NSString stringWithFormat:@"%lu", self.adultNumber];
            }
            break;
        case 2:
            if(self.childNumber > 0){
                self.childNumber -= 1;
                self.childrenLabel.text = [NSString stringWithFormat:@"%lu", self.childNumber];
            }
            break;
        case 3:
            if(self.roomsNumber > 0){
                self.roomsNumber -= 1;
                self.roomLabel.text = [NSString stringWithFormat:@"%lu", self.roomsNumber];
            }
            break;
        default:
            break;
    }
}
- (IBAction)applyButtonClicked:(UIBarButtonItem *)sender{
    if([self.delegate respondsToSelector:@selector(sendDataBack:adults:children:)]){
        [self.delegate sendDataBack:self.roomsNumber adults:self.adultNumber children:self.childNumber];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
