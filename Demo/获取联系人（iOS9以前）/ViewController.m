//
//  ViewController.m
//  获取联系人（iOS9以前）
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self noUI];
}

- (void)noUI
{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRef ab = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(ab, ^(bool granted, CFErrorRef error) {
            if (error) {
                NSLog(@"error-%@", error);
            }else {
                if (granted) {
                    
                }
            }
        });
        CFRelease(ab);
    }
    
    ABAddressBookRef ab = ABAddressBookCreate();
    CFArrayRef peopleArr = ABAddressBookCopyArrayOfAllPeople(ab);
    CFIndex peopleCount = CFArrayGetCount(peopleArr);
    for (NSInteger i = 0; i < peopleCount; i ++) {
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArr, i);
        
        CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *first = (__bridge_transfer NSString *)(firstName);
        NSString *last = (__bridge_transfer NSString *)(lastName);
        NSLog(@"%@ %@", first, last);
        ABMultiValueRef phoneNums = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phoneNums);
        for (NSInteger i = 0; i < phoneCount; i ++) {
            CFStringRef phoneLabel = ABMultiValueCopyLabelAtIndex(phoneNums,  i);
            CFStringRef phoneNum = ABMultiValueCopyValueAtIndex(phoneNums, i);
            NSLog(@"%@ %@", phoneLabel, phoneNum);
            CFRelease(phoneLabel);
            CFRelease(phoneNum);
        }
        
        CFRelease(phoneNums);
    }
    
    CFRelease(peopleArr);
    CFRelease(ab);
}

- (void)haveUI
{
    ABPeoplePickerNavigationController *abPickerVC = [[ABPeoplePickerNavigationController alloc] init];
    abPickerVC.peoplePickerDelegate = self;
    [self presentViewController:abPickerVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0) {
    
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *first = (__bridge_transfer NSString *)(firstName);
    NSString *last = (__bridge_transfer NSString *)(lastName);
    NSLog(@"%@ %@", first, last);
    ABMultiValueRef phoneNums = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex phoneCount = ABMultiValueGetCount(phoneNums);
    for (NSInteger i = 0; i < phoneCount; i ++) {
        CFStringRef phoneLabel = ABMultiValueCopyLabelAtIndex(phoneNums,  i);
        CFStringRef phoneNum = ABMultiValueCopyValueAtIndex(phoneNums, i);
        NSLog(@"%@ %@", phoneLabel, phoneNum);
        CFRelease(phoneLabel);
        CFRelease(phoneNum);
    }
    
    CFRelease(phoneNums);
}

@end
