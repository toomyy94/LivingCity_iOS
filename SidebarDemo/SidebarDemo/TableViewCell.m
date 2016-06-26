//
//  TableViewCell.m
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "TableViewCell.h"
#import "UUChart/UUChart.h"

@interface TableViewCell ()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation TableViewCell

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                   dataSource:self
                                        style:UUChartStyleLine];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"%dH",i+1];
        [xTitles addObject:str];
    }
    return xTitles;
}


- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:11];
}


- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *ary = @[@"22",@"23",@"22",@"23",@"23",@"22",@"24",@"25",@"26",@"28",@"29"];

    return @[ary];
}


- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor green],[UUColor red],[UUColor brown]];
}

- (CGRange)chartRange:(UUChart *)chart
{
    return CGRangeMake(50, 1);

}


- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    if (path.row == 2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}


- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return path.row == 2;
}
@end
