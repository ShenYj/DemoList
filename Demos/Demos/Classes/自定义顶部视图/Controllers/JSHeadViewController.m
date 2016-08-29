
#import "JSHeadViewController.h"
#import "JSFriendsModel.h"
#import "JSHeadCell.h"
#import "JSFooterView.h"

static NSString *reuseId = @"friends";

@interface JSHeadViewController () <UITableViewDataSource,friendsFooterViewBtnClickDelegate>

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,strong) NSArray *friendsArray;

@end

@implementation JSHeadViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 250;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"headerView"];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 200)];
    
    [backgroundView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 200);
    
    self.tableView.backgroundView = backgroundView;
    self.tableView.tableHeaderView = headView;
    
    [self.tableView registerClass:[JSHeadCell class] forCellReuseIdentifier:reuseId];
    
#pragma mark -- FooterView
    
    JSFooterView *footerView = [[JSFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 50)];
    
    self.tableView.tableFooterView = footerView;
    
    footerView.delegate = self;
    
    
}

#pragma mark -- FooterView代理方法

- (void)friendsFooterViewDelegateWithFooterView:(UIView *)footerView{
    
    NSMutableArray *marray = [NSMutableArray arrayWithArray:self.friendsArray];
    
    int randomMessageNum = arc4random_uniform((int)self.friendsArray.count - 1);
    
    JSFriendsModel *randomFriends = marray[randomMessageNum];
    
    [marray addObject:randomFriends];
    
    self.friendsArray = marray;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.friendsArray.count - 1) inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
}

#pragma mark --  UITableViewDataSource 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.friendsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JSHeadCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
    JSFriendsModel *friends = self.friendsArray[indexPath.row];
    
    cell.friends = friends;
    
    return cell;
    
}
//滚动时headerView效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offSet = scrollView.contentOffset;
    CGRect imageViewFrame = self.imageView.frame;
    
    if (offSet.y > 0) {

        imageViewFrame.origin.y = -offSet.y;
        self.imageView.frame = imageViewFrame;
        
    }else{
        
        imageViewFrame.size.height = 200 - offSet.y;
        self.imageView.frame = CGRectMake(-(imageViewFrame.size.height)*0.5, 0, SCREEN_SIZE.width + imageViewFrame.size.height, imageViewFrame.size.height);
        
    }
    
    
}
#pragma mark -- 懒加载
-(NSArray *)friendsArray{
    
    if (_friendsArray == nil) {
        
        _friendsArray = [JSFriendsModel friendsWithPlistFileName:@"friends"];
    }
    return _friendsArray;
}

@end
