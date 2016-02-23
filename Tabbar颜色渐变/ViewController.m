//
//  ViewController.m
//  Tabbar颜色渐变
//
//  Created by dpfst520 on 16/2/22.
//  Copyright © 2016年 NttData.dang. All rights reserved.
//

#import "ViewController.h"

#define Height  [UIScreen mainScreen].bounds.size.height
#define Width   [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    UIView *view_bar;
    UIImageView *imageView;
    
    UIView *tabBar_view;
    
    
}

@property (nonatomic, strong)UITableView *tableView;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self SetNavBarHidden:YES];
    
    [self SetHeaderView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    [self SetHeaderView];
    [self NavigationBar];
    [self setTabBarView];
    
}

-(void) SetNavBarHidden:(BOOL) isHidden
{
    self.navigationController.navigationBarHidden = isHidden;
}

- (UIView *)NavigationBar
{
    view_bar = [[UIView alloc]init];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.1) {
        
        view_bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44 + 20);
    } else {
        
        view_bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    }
    
    view_bar.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:view_bar];
    
    return view_bar;
}

-(void)SetHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Width,150)];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,Width,180)];
    
    UIImage* img =[UIImage imageNamed:@"1.png"];//原图
    
    CGRect rect = CGRectMake(0, 0,2000, 400);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage],rect);
    
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    
    [imageView setImage:image1];
    
    [headerView addSubview:imageView];
    
    
    self.tableView.tableHeaderView = imageView;
    
    
}

- (UIView *)setTabBarView
{
    tabBar_view = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 30, Width, 30)];
    
    tabBar_view.backgroundColor = [UIColor redColor];
    
    self.tableView.tableFooterView = tabBar_view;
    
    return tabBar_view;
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"text";
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y < -20) {
        
        [view_bar setHidden:YES];
        
    } else if (self.tableView.contentOffset.y < 700) {
        [view_bar setHidden:NO];
        
        view_bar.backgroundColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:self.tableView.contentOffset.y / 1000];
    } else {
        
        [view_bar setHidden:NO];
        
        view_bar.backgroundColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:0.7];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
