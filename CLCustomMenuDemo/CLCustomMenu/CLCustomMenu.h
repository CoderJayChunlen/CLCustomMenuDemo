//
//  CLCustomMenu.h
//  CLCustomMenuDemo
//
//  Created by Chunlen Jay on 2018/4/10.
//  Copyright © 2018年 Chunlen Jay. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^menuDidSelectRowAtIndexPath)(NSIndexPath *indexPath);


typedef void(^Dismiss)(void);
@interface CLCustomMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) Dismiss dismiss;
@property (nonatomic, copy) menuDidSelectRowAtIndexPath menuDidSelectRowAtIndexPath;

- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight isLeft:(BOOL)isLeft;

- (void)dismissWithCompletion:(void (^)(CLCustomMenu *object))completion;

@end
