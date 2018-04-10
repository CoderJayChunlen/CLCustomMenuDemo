//
//  CLCustomMenu.m
//  CLCustomMenuDemo
//
//  Created by Chunlen Jay on 2018/4/10.
//  Copyright © 2018年 Chunlen Jay. All rights reserved.
//

#import "CLCustomMenu.h"

#define TopToView 10.0f
#define LeftToView 10.0f
#define RightToView 10.0f

#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)

@interface CLCustomMenu()
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) BOOL isLeft;
@property (nonatomic, assign) CGFloat width;


@end

@implementation CLCustomMenu

- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight isLeft:(BOOL)isLeft
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        if (rowHeight <= 0) {
            rowHeight = 44;
        }
        
        self.backgroundColor = [UIColor clearColor];
        self.origin = origin;
        self.rowHeight = rowHeight;
        self.isLeft = isLeft;
        self.width = width;
        self.titles = [titles copy];
        self.images = [images copy];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x + (isLeft==YES?LeftToView:(-RightToView)), origin.y + TopToView, width, rowHeight * titles.count) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        _tableView.layer.cornerRadius = 2;
        _tableView.bounces = NO;
        _tableView.separatorColor = [UIColor colorWithWhite:0.3 alpha:1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CLCustomMenuCell"];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:CellLineEdgeInsets];
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self.tableView setLayoutMargins:CellLineEdgeInsets];
            
        }
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLCustomMenuCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.titles[indexPath.row];
    if (self.images.count > indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.menuDidSelectRowAtIndexPath) {
        self.menuDidSelectRowAtIndexPath(indexPath);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithCompletion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:CellLineEdgeInsets];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:CellLineEdgeInsets];
        
    }
    
}

- (void)dismissWithCompletion:(void (^)(CLCustomMenu *object))completion
{
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0;
        weakSelf.tableView.frame = CGRectMake(weakSelf.origin.x +  (weakSelf.isLeft==YES?LeftToView:(weakSelf.width-RightToView)), weakSelf.origin.y + TopToView, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (completion) {
            completion(weakSelf);
        }
        if (weakSelf.dismiss) {
            weakSelf.dismiss();
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self dismissWithCompletion:nil];
    }
}

- (void)drawRect:(CGRect)rect

{
    
    
    //    [colors[serie] setFill];
    
    //拿到当前视图准备好的画板
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    if (_isLeft) {//从左边展开
        
        CGContextMoveToPoint(context,
                             LeftToView * 2.5, TopToView * 0.5);//设置起点
        
        CGContextAddLineToPoint(context,
                                LeftToView * 2, TopToView);
        
        CGContextAddLineToPoint(context,
                                LeftToView * 3, TopToView);
    }else{//从左边展开
        CGContextMoveToPoint(context,
                             [UIScreen mainScreen].bounds.size.width-LeftToView * 2.5, TopToView * 0.5);//设置起点
        
        CGContextAddLineToPoint(context,
                                [UIScreen mainScreen].bounds.size.width-LeftToView * 2, TopToView);
        
        CGContextAddLineToPoint(context,
                                [UIScreen mainScreen].bounds.size.width- LeftToView * 3, TopToView);
    }
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [self.tableView.backgroundColor setFill]; //设置填充色
    
    //    [self.tableView.backgroundColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
}




@end
