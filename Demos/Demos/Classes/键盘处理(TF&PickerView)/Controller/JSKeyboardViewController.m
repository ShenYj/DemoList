//
//  ViewController.m
//  键盘处理
//
//  Created by ShenYj on 16/4/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSKeyboardViewController.h"
#import "Masonry.h"
#import "SJProvinces.h"

@interface JSKeyboardViewController () <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak) UITextField *birthdayTextField;
@property (nonatomic,weak) UITextField *cityTextField;
@property (nonatomic,weak) UIDatePicker *datePicker;
@property (nonatomic,weak) UIPickerView *pickerView;
@property (nonatomic,strong) NSArray *provincesArray;
@property (nonatomic,assign) NSInteger lastIndex;

@end

@implementation JSKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark -- specification
    
    UILabel *speLabel = [[UILabel alloc]init];
    speLabel.text = @"键盘处理练习";
    speLabel.font = [UIFont systemFontOfSize:18];
    speLabel.contentMode = NSTextAlignmentCenter;
    
    [self.view addSubview:speLabel];
    
    [speLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_offset(40);
        
    }];
    
#pragma mark -- LoginView
    
    UIView *loginView = [[UIView alloc]init];
    loginView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self.view);
        make.height.mas_offset(160);
        make.centerY.mas_equalTo(self.view).mas_offset(-100);
        
    }];
    
    
    UILabel *birthdayLabel = [[UILabel alloc]init];
    birthdayLabel.text = @"生日:";
    birthdayLabel.font = [UIFont systemFontOfSize:15];
    [loginView addSubview:birthdayLabel];
    
    [birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(loginView).mas_offset(40);
        make.top.mas_equalTo(loginView).mas_offset(30);
        make.width.mas_offset(60);
        make.height.mas_offset(40);
        
    }];
    
    UITextField *birthdayTextField = [[UITextField alloc]init];
//    birthdayTextField.backgroundColor = [UIColor lightGrayColor];
    self.birthdayTextField = birthdayTextField;
    [loginView addSubview:birthdayTextField];
    
    [birthdayTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(birthdayLabel.mas_right).mas_offset(20);
//        make.top.mas_equalTo(loginView).mas_offset(30);
        make.centerY.mas_equalTo(birthdayLabel);
        make.width.mas_offset(180);
        make.height.mas_offset(40);
        
    }];
    
    UILabel *cityLabel = [[UILabel alloc]init];
    cityLabel.text = @"城市：";
    cityLabel.font = [UIFont systemFontOfSize:15];
    [loginView addSubview:cityLabel];
    
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(birthdayLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(40);
        make.width.mas_offset(60);
        make.height.mas_offset(40);
        
    }];
    
    UITextField *cityTextField = [[UITextField alloc]init];
//    cityTextField.backgroundColor = [UIColor lightGrayColor];
    self.cityTextField= cityTextField;
    [loginView addSubview:cityTextField];
    
    [cityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(birthdayLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(cityLabel.mas_right).mas_offset(20);
        make.width.mas_offset(180);
        make.height.mas_offset(40);
        
    }];
    
#pragma mark -- set TextField widget's delegate
    
    self.birthdayTextField.delegate = self;
    self.cityTextField.delegate = self;
    
    
#pragma mark --  TextField's inputView
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    self.datePicker = datePicker;
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker addTarget:self action:@selector(selectBirthdayDateInfo:) forControlEvents:UIControlEventValueChanged];
    
    self.birthdayTextField.inputView = datePicker;
    
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    self.pickerView = pickerView;
    
    
    self.cityTextField.inputView = pickerView;

    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    
    
    
#pragma mark -- Set Max Date
    
    
    
    
    
#pragma mark -- TextField's inputAccessoryView
    
//    UIToolbar *toolbar = [[UIToolbar alloc]init];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
//    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]init];
//    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]init];

    
}



- (void)selectBirthdayDateInfo :(UIDatePicker *)datePicker{
    
    NSDate *birthdayDate = datePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *brithdayDate = [formatter stringFromDate:birthdayDate];
    
    self.birthdayTextField.text = brithdayDate;
    
}


#pragma mark -- UITextFieldDelegate method

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return NO;
    
    
}


// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    self.birthdayTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    
    
}

#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( !component ) {
        
        return self.provincesArray.count;
        
    }else{
        
        SJProvinces *provinces = self.provincesArray[self.lastIndex];
        
        return provinces.cities.count;
        
    }
    
    
}

#pragma mark -- UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if ( !component ) {
        
        SJProvinces *provinces = self.provincesArray[row];
        
        return provinces.name;
        
    }else{
        
        SJProvinces *provinces = self.provincesArray[self.lastIndex];
        
        return provinces.cities[row];
        
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if ( !component ) {
        
        NSInteger lastIndex = [pickerView selectedRowInComponent:component];
        
        self.lastIndex = lastIndex;
        
        [pickerView selectRow:0 inComponent:1 animated:YES];

        [pickerView reloadComponent:1];
        
    }
    
    NSInteger currentProvince = [pickerView selectedRowInComponent:0];
    NSInteger currentCity = [pickerView selectedRowInComponent:1];
    
    SJProvinces *provinces = self.provincesArray[currentProvince];
    
    NSString *province = provinces.name;
    NSString *city = provinces.cities[currentCity];
    
    NSString *proWithCity = [NSString stringWithFormat:@"%@ - %@",province,city];
    
    self.cityTextField.text = proWithCity;
    
    
}

#pragma mark -- load data

-(NSArray *)provincesArray{
    
    if (!_provincesArray) {
        
        _provincesArray = [SJProvinces provincesWithPlistFileName:@"provinces"];
    }
    return _provincesArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

@end
