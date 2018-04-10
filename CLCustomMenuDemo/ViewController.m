//
//  ViewController.m
//  CLCustomMenuDemo
//
//  Created by Chunlen Jay on 2018/4/10.
//  Copyright © 2018年 Chunlen Jay. All rights reserved.
//

#import "ViewController.h"
#import "CLCustomMenu.h"
@interface ViewController ()
@property (nonatomic, strong) CLCustomMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addAction:(UIBarButtonItem *)sender {
    __weak __typeof(self) weakSelf = self;

    if (!self.menu) {
        self.menu = [[CLCustomMenu alloc] initWithTitles:@[@"附近学校", @"联赛流程", @"其他联赛", @"校内群聊", @"邀请好友"] images:@[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"] origin:CGPointMake([UIScreen mainScreen].bounds.size.width - 125, 0) width:125 rowHeight:44 isLeft:NO];
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        _menu.menuDidSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
            NSLog(@"选择第%ld行",indexPath.row);
        };
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(CLCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
