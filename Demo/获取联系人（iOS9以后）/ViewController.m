//
//  ViewController.m
//  获取联系人（iOS9以后）
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self noUI];
}

- (void)noUI
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error-%@", error);
            }else {
                
            }
        }];
    }
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactFamilyNameKey, CNContactGivenNameKey]];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@", contact.familyName, contact.givenName);
    }];
}

- (void)haveUI
{
    CNContactPickerViewController *snPickerVC = [[CNContactPickerViewController alloc] init];
    snPickerVC.delegate = self;
    [self presentViewController:snPickerVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSLog(@"%@ %@", contact.familyName, contact.givenName);
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts {
    for (CNContact *contact in contacts) {
        NSLog(@"%@ %@", contact.givenName, contact.familyName);
    }
}

@end
