//
//  ViewController.m
//  UIPickerView
//
//  Created by 刘丰 on 2017/8/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFCityItem.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *showCityL;

@property(nonatomic,weak) UIPickerView *pickerView;

@property(nonatomic,strong) NSArray<LFCityItem *> *provinces;
@property(nonatomic,strong) LFCityItem *province;
@property(nonatomic,strong) LFCityItem *city;
@property(nonatomic,strong) LFCityItem *area;

@end

@implementation ViewController

- (NSArray<LFCityItem *> *)provinces
{
    if (!_provinces) {
        NSString *provincePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        NSData *provinceD = [NSData dataWithContentsOfFile:provincePath];
        NSArray *provinces = [NSJSONSerialization JSONObjectWithData:provinceD options:NSJSONReadingMutableContainers error:nil];
        _provinces = [LFCityItem mj_objectArrayWithKeyValuesArray:provinces];
    }
    return _provinces;
}

- (LFCityItem *)province
{
    if (!_province) {
        _province = self.provinces.firstObject;
    }
    return _province;
}

- (LFCityItem *)city
{
    if (!_city) {
        _city = self.province.son.firstObject;
    }
    return _city;
}

- (LFCityItem *)area
{
    if (!_area) {
        _area = self.city.son.firstObject;
    }
    return _area;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
        picker.backgroundColor = [UIColor redColor];
        [self.view addSubview:picker];
        _pickerView = picker;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark -
#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.provinces.count;
        case 1:
            return self.province.son.count;
        case 2:
            return self.city.son.count;
        default:
            return 0;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.provinces[row].area_district;
        case 1:
            return self.province.son[row].area_district;
        case 2:
            return self.city.son[row].area_district;
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            self.province = self.provinces[row];
            self.city = self.province.son.firstObject;
            self.area = self.city.son.firstObject;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
        break;
        case 1: {
            self.city = self.province.son[row];
            self.area = self.city.son.firstObject;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
        break;
        case 2: {
            self.area = self.city.son[row];
        }
        break;
        default:
            break;;
    }
    
    self.showCityL.text = [NSString stringWithFormat:@"%@-%@-%@", self.province.area_district, self.city.area_district, self.area.area_district];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

@end
