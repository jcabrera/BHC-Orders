//
//  ViewController.m
//  BHC Orders
//
//  Created by Jennifer Cabrera on 1/29/15.
//  Copyright (c) 2015 Jennifer Cabrera. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController () <
MFMailComposeViewControllerDelegate,
UINavigationControllerDelegate
>


@property (weak, nonatomic) IBOutlet UITextField *orderNum;
@property (weak, nonatomic) IBOutlet UIButton *sendEmail;
@property (weak, nonatomic) IBOutlet UIPickerView *soldToPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *productPicker;
@property (strong, nonatomic) NSArray *customerNames;
@property (strong, nonatomic) NSArray *productNames;
@property (weak, nonatomic) NSString *selectedCustomer;
@property (weak, nonatomic) NSString *selectedProduct;
@property (weak, nonatomic) IBOutlet UITextField *billTo;

@property (weak, nonatomic) IBOutlet UITextField *shipTo;
@property (weak, nonatomic) IBOutlet UIDatePicker *deliveryDate;
@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (weak, nonatomic) IBOutlet UITextField *customerPO;
@property (weak, nonatomic) IBOutlet UITextField *productAmount;
@property (weak, nonatomic) IBOutlet UITextField *productPrice;
@property (weak, nonatomic) IBOutlet UITextField *orderNotes;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *shipFrom;
@property(nonatomic) UIScrollViewKeyboardDismissMode keyboardDismissMode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"Customers" withExtension:@"plist"];
    NSArray *unsortedCustomerNames = [NSArray arrayWithContentsOfURL:plistURL];
    NSArray *sortedCustomerNames = [unsortedCustomerNames sortedArrayUsingSelector:@selector(compare:)];
    self.customerNames = sortedCustomerNames;
    NSURL *plistURL2 = [bundle URLForResource:@"Products" withExtension:@"plist"];
    NSArray *unsortedProductNames = [NSArray arrayWithContentsOfURL:plistURL2];
    NSArray *sortedProductNames = [unsortedProductNames sortedArrayUsingSelector:@selector(compare:)];
    self.productNames = sortedProductNames;
    
    [(UIScrollView*)self.scrollView setContentSize:CGSizeMake(320, 2000)];
    self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"BHC Order"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"jennifer@berniehaskins.com"];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [picker setToRecipients:toRecipients];
    //[picker setCcRecipients:ccRecipients];
    //[picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
    
    // Fill out the email body text
    
    NSString *emailBody = @"Here is a new order";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    /*
    self.feedbackMsg.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            self.feedbackMsg.text = @"Result: Mail sending canceled";
            break;
        case MFMailComposeResultSaved:
            self.feedbackMsg.text = @"Result: Mail saved";
            break;
        case MFMailComposeResultSent:
            self.feedbackMsg.text = @"Result: Mail sent";
            break;
        case MFMailComposeResultFailed:
            self.feedbackMsg.text = @"Result: Mail sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    */
    
     [self dismissViewControllerAnimated:YES completion:NULL];
    }

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction) buttonPressed:(id)sender {
    NSString *orderNumText = [NSString stringWithFormat:@"BHC#:  %@", self.orderNum.text];
    NSString *customerNameText = [NSString stringWithFormat:@"Sold to: %@", self.selectedCustomer];
    NSString *billToText = [NSString stringWithFormat:@"Bill to: %@", self.billTo.text];
    NSString *shipToText = [NSString stringWithFormat:@"Ship to: %@", self.shipTo.text];
    NSString *shipFromText = [NSString stringWithFormat:@"Sold to: %@", self.shipFrom.text];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    NSString *formattedDate = [dateFormatter stringForObjectValue:self.deliveryDate.date];
    NSString *deliveryDateText = [NSString stringWithFormat:@"Delivery date: %@", formattedDate];
    NSString *productNameText = [NSString stringWithFormat:@"Product: %@", self.selectedProduct];
    NSString *productAmountText = [NSString stringWithFormat:@"Amount: %@", self.productAmount];
    NSString *customerPOText = [NSString stringWithFormat:@"Customer PO: %@", self.customerPO];
    NSString *productPriceText = [NSString stringWithFormat:@"Price: $%@", self.productPrice];
    NSString *orderNotesText = [NSString stringWithFormat:@"Notes: %@", self.orderNotes];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"BHC Order"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"jennifer@berniehaskins.com"];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [picker setToRecipients:toRecipients];
    //[picker setCcRecipients:ccRecipients];
    //[picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
    
    // Fill out the email body text
    
    NSString *emailBody = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@", orderNumText,customerNameText,billToText, shipToText,shipFromText, deliveryDateText, productNameText, productAmountText, customerPOText, productPriceText, orderNotesText];
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:NULL];
    

}

- (IBAction)backgroundTap:(id)sender {
    [self.orderNum resignFirstResponder];
}
- (IBAction)nextPageButtonPressed:(id)sender {
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.soldToPicker) {
    return [self.customerNames count];
    } else {
        return [self.productNames count];
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.soldToPicker) {
    return self.customerNames[row];
    } else {
        return self.productNames[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.soldToPicker) {
    self.selectedCustomer = self.customerNames[row];
    } else {
        self.selectedProduct = self.productNames[row];
    }
        
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:
(UIView *)view {
    UILabel* tView = (UILabel*)view;
   
    if (pickerView == self.soldToPicker) {
        
        if (!tView){
            tView = [[UILabel alloc] init];
        tView.adjustsFontSizeToFitWidth = YES;
    
    
    tView.text = [self.customerNames objectAtIndex:row];
        }
   }
    else {
       
        if (!tView){
            tView = [[UILabel alloc] init];
        tView.adjustsFontSizeToFitWidth = NO;
        tView.text = [self.productNames objectAtIndex:row];
    }
    }
    return tView;
} 


@end
