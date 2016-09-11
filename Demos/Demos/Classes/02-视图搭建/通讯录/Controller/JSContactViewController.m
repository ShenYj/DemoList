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


static NSString * const reuseID = @"abc";

@interface JSContactViewController () <CNContactPickerDelegate>

@property (nonatomic,strong) UIButton *contactButton;

// 数据容器
@property (nonatomic,strong) NSArray *dataArr;


// 属性展示
@property (nonatomic, strong) JSContactLabel *namePrefix;
@property (nonatomic, strong) JSContactLabel *givenName;
@property (nonatomic, strong) JSContactLabel *middleName;
@property (nonatomic, strong) JSContactLabel *familyName;
@property (nonatomic, strong) JSContactLabel *previousFamilyName;
@property (nonatomic, strong) JSContactLabel *nameSuffix;
@property (nonatomic, strong) JSContactLabel *nickname;
@property (nonatomic, strong) JSContactLabel *phoneticGivenName;
@property (nonatomic, strong) JSContactLabel *phoneticMiddleName;
@property (nonatomic, strong) JSContactLabel *phoneticFamilyName;
@property (nonatomic, strong) JSContactLabel *organizationName;
@property (nonatomic, strong) JSContactLabel *departmentName;
@property (nonatomic, strong) JSContactLabel *jobTitle;
@property (nonatomic, strong) JSContactLabel *note;
@property (nonatomic, strong) JSContactLabel *phoneNumber;
@property (nonatomic, strong) JSContactLabel *emailAddress;
@property (nonatomic, strong) JSContactLabel *postalAddress;
@property (nonatomic, strong) JSContactLabel *urlAddress;
@property (nonatomic, strong) JSContactLabel *contactRelation;
@property (nonatomic, strong) JSContactLabel *socialProfile;
@property (nonatomic, strong) JSContactLabel *instantMessageAddress;
@property (nonatomic, strong) JSContactLabel *birthday;
@property (nonatomic, strong) JSContactLabel *nonGregorianBirthday;
@property (nonatomic, strong) JSContactLabel *date;

@end

@implementation JSContactViewController{
    
    NSArray         *_dataArr;          // 数据容器
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.contactButton];
    
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
    
    
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
}

/*!
 * @abstract Plural delegate methods.
 * @discussion These delegate methods will be invoked when the user is done selecting multiple contacts or properties.
 * Implementing one of these methods will configure the picker for multi-selection.
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
    
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *propertyName = self.dataArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.textLabel.text = propertyName;
    
    return cell;
    
}

#pragma mark - lazy

- (UIButton *)contactButton {
    
    if (_contactButton == nil) {
        _contactButton = [[UIButton alloc] init];
        [_contactButton setTitle:@"打开通讯录" forState:UIControlStateNormal];
        [_contactButton setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_contactButton addTarget:self action:@selector(clickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}

- (NSArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [JSContactModel js_objProperties];
    }
    return _dataArr;
}

- (JSContactLabel *)namePrefix{
    if (_namePrefix == nil) {
        _namePrefix = [[JSContactLabel alloc] init];
    }
    return _namePrefix;
}

- (JSContactLabel *)givenName{
    if (_givenName == nil) {
        _givenName = [[JSContactLabel alloc] init];
    }
    return _givenName;
}

- (JSContactLabel *)middleName{
    if (_middleName == nil) {
        _middleName = [[JSContactLabel alloc] init];
    }
    return _middleName;
}

- (JSContactLabel *)familyName{
    if (_familyName == nil) {
        _familyName = [[JSContactLabel alloc] init];
    }
    return _familyName;
}

- (JSContactLabel *)previousFamilyName{
    if (_previousFamilyName == nil) {
        _previousFamilyName = [[JSContactLabel alloc] init];
    }
    return _previousFamilyName;
}

- (JSContactLabel *)nameSuffix{
    if (_nameSuffix == nil) {
        _nameSuffix = [[JSContactLabel alloc] init];
    }
    return _nameSuffix;
}

- (JSContactLabel *)nickname{
    if (_nickname == nil) {
        _nickname = [[JSContactLabel alloc] init];
    }
    return _nickname;
}

- (JSContactLabel *)phoneticGivenName{
    if (_phoneticGivenName == nil) {
        _phoneticGivenName = [[JSContactLabel alloc] init];
    }
    return _phoneticGivenName;
}

- (JSContactLabel *)phoneticMiddleName{
    if (_phoneticMiddleName == nil) {
        _phoneticMiddleName = [[JSContactLabel alloc] init];
    }
    return _phoneticMiddleName;
}

- (JSContactLabel *)phoneticFamilyName{
    if (_phoneticFamilyName == nil) {
        _phoneticFamilyName = [[JSContactLabel alloc] init];
    }
    return _phoneticFamilyName;
}

- (JSContactLabel *)organizationName{
    if (_organizationName == nil) {
        _organizationName = [[JSContactLabel alloc] init];
    }
    return _organizationName;
}

- (JSContactLabel *)departmentName{
    if (_departmentName == nil) {
        _departmentName = [[JSContactLabel alloc] init];
    }
    return _departmentName;
}

- (JSContactLabel *)jobTitle{
    if (_jobTitle == nil) {
        _jobTitle = [[JSContactLabel alloc] init];
    }
    return _jobTitle;
}

- (JSContactLabel *)note{
    if (_note == nil) {
        _note = [[JSContactLabel alloc] init];
    }
    return _note;
}

- (JSContactLabel *)phoneNumber{
    if (_phoneNumber == nil) {
        _phoneNumber = [[JSContactLabel alloc] init];
    }
    return _phoneNumber;
}

- (JSContactLabel *)emailAddress{
    if (_emailAddress == nil) {
        _emailAddress = [[JSContactLabel alloc] init];
    }
    return _emailAddress;
}

- (JSContactLabel *)postalAddress{
    if (_postalAddress == nil) {
        _postalAddress = [[JSContactLabel alloc] init];
    }
    return _postalAddress;
}

- (JSContactLabel *)urlAddress{
    if (_urlAddress == nil) {
        _urlAddress = [[JSContactLabel alloc] init];
    }
    return _urlAddress;
}

- (JSContactLabel *)contactRelation{
    if (_contactRelation == nil) {
        _contactRelation = [[JSContactLabel alloc] init];
    }
    return _contactRelation;
}

- (JSContactLabel *)socialProfile{
    if (_socialProfile == nil) {
        _socialProfile = [[JSContactLabel alloc] init];
    }
    return _socialProfile;
}

- (JSContactLabel *)instantMessageAddress{
    if (_instantMessageAddress == nil) {
        _instantMessageAddress = [[JSContactLabel alloc] init];
    }
    return _instantMessageAddress;
}

- (JSContactLabel *)birthday{
    if (_birthday == nil) {
        _birthday = [[JSContactLabel alloc] init];
    }
    return _birthday;
}

- (JSContactLabel *)nonGregorianBirthday{
    if (_nonGregorianBirthday == nil) {
        _nonGregorianBirthday = [[JSContactLabel alloc] init];
    }
    return _nonGregorianBirthday;
}

- (JSContactLabel *)date{
    if (_date == nil) {
        _date = [[JSContactLabel alloc] init];
    }
    return _date;
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
