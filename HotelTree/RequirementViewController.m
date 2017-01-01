//
//  RequirementViewController.m
//  HotelTree
//
//  Created by Xinyuan Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "RequirementViewController.h"

@interface RequirementViewController ()

@property( nonatomic)NSInteger roomsNumber;
@property( nonatomic)NSInteger adultNumber;
@property( nonatomic)NSInteger childNumber;


@end

@implementation RequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            break;
         case 2:
            self.childNumber += 1;
            break;
        case 3:
            self.roomsNumber += 1;
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
            }
            break;
        case 2:
            if(self.childNumber > 0){
                self.childNumber -= 1;
            }
            break;
        case 3:
            if(self.roomsNumber > 0){
                self.roomsNumber -= 1;
            }
            break;
        default:
            break;
    }
}
- (IBAction)applyButtonClicked:(UIBarButtonItem *)sender{
    if([self.delegate respondsToSelector:@selector(sendDataBack:adults:children:)]){
        [self.delegate sendDataBack:self.roomsNumber adults:self.adultNumber children:self.childNumber];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
