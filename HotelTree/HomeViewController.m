//
//  HomeViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray *homeArray;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
