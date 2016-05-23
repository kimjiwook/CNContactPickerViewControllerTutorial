//
//  ViewController.m
//  CNContactPickerViewControllerTutorial
//
//  Created by kimjiwook on 2016. 5. 23..
//  Copyright © 2016년 kimjiwook. All rights reserved.
//

#import "ViewController.h"
// iOS 9 이후 부터 주소록 API 변경되었습니다.
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface ViewController () <CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goAddress:(id)sender {
    CNContactPickerViewController *cnContactPickerViewController = [[CNContactPickerViewController alloc] init];
    [cnContactPickerViewController setDelegate:self];
    // #. 이메일이 없다면 선택이 안되게 진행하기.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
    cnContactPickerViewController.predicateForEnablingContact = predicate;
    
    // 이동하기
    [self presentViewController:cnContactPickerViewController animated:YES completion:nil];
}

- (void) contactPickerDidCancel:(CNContactPickerViewController *)picker {
    NSLog(@"선택 취소");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSLog(@"값 선택 : %@",contact);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    NSString *tempString = [NSString stringWithFormat:@"이름 : %@ \n",contact.familyName];
    // 1. 핸드폰번호 (Phone Numbers)
    tempString = [NSString stringWithFormat:@"%@번호 : ",tempString];

    for (CNLabeledValue *phoneNumber in contact.phoneNumbers) {
        CNPhoneNumber *phone = phoneNumber.value;
        tempString = [NSString stringWithFormat:@"%@<%@>",tempString,phone.stringValue];
    }
    
    // 2. 이메일 (Emails)
    tempString = [NSString stringWithFormat:@"%@\n이메일 : ",tempString];
    for (CNLabeledValue *email in contact.emailAddresses) {
        tempString = [NSString stringWithFormat:@"%@<%@>",tempString,email.value];
    }
    
    // 3. 택스트뷰에 넣어주기.
    self.textView.text = tempString;
}

@end
