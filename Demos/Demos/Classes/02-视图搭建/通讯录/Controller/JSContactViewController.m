//
//  JSContactViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSContactViewController.h"
#import "JSContactLabel.h"
#import "JSContactModel.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>




static NSString * const reuseID = @"abc";

@interface JSContactViewController () <CNContactPickerDelegate>

// 数据容器
@property (nonatomic,strong) NSArray *dataArr;

// 选中的联系人
@property (nonatomic,strong) CNContact *selectedContact;
// 选中的联系人信息
@property (nonatomic,strong) NSMutableDictionary *contactInfo;


@end

@implementation JSContactViewController

- (NSString *)title{
    
    return @"CNContact属性列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickContactButton:)];
    
}

#pragma mark - target 


- (void)clickContactButton:(UIButton *)sender{
    
    CNContactPickerViewController *picterViewController = [[CNContactPickerViewController alloc] init];
    
    picterViewController.delegate = self;
    
    [self presentViewController:picterViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CNContactPickerDelegate

// 实现didSelectContact代理方法后,就不会再进入联系人的详情界面,也就不会再执行didSelectContactProperty方法


/*!
 * @abstract Invoked when the picker is closed.
 * @discussion The picker will be dismissed automatically after a contact or property is picked.
 */
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}

/*!
 * @abstract Singular delegate methods.
 * @discussion These delegate methods will be invoked when the user selects a single contact or property.
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    
    if (self.contactInfo.count > 0) {
        
        [self.contactInfo removeAllObjects];
    }

    NSDictionary *dict = [contact dictionaryWithValuesForKeys:[JSContactModel js_objProperties]];
    
    self.contactInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSLog(@"%@",self.contactInfo);

    
    [self.tableView reloadData];
    //JSContactModel *contactModel = [JSContactModel contactModelWithDict:dict];
    
//    // [CNContact js_objProperties]
//    for (NSString *propertyName in self.dataArr) {
//        
//        SEL propertyMethod = NSSelectorFromString(propertyName);
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        
//        id result = [contact performSelector:propertyMethod];
//        
//        if ( result ) {
//            
//            [self.contactInfo setObject:result forKey:propertyName];
//#pragma clang diagnostic pop
//            
//            
//        }
//        
//    }
//

   
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
}

/*!
 * @abstract Plural delegate methods.
 * @discussion These delegate methods will be invoked when the user is done selecting multiple contacts or properties.
 * Implementing one of these methods will configure the picker for multi-selection.
 */

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
//    
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
//    
//}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *propertyName = self.dataArr[indexPath.row];
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = propertyName;
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.detailTextLabel.text = @" ";
    cell.detailTextLabel.textColor = [UIColor js_randomColor];
    
    if (self.contactInfo.count > 0) {
        
        cell.detailTextLabel.text = self.contactInfo[propertyName];
    }
    
    return cell;
}

#pragma mark - lazy

//- (NSMutableDictionary *)contactInfo{
//    
//    if (_contactInfo == nil) {
//        _contactInfo = [NSMutableDictionary dictionaryWithCapacity:5];
//    }
//    return _contactInfo;
//}

- (NSArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [JSContactModel js_objProperties];
    }
    return _dataArr;
}







@end
