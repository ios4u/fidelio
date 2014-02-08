//
//  ViewController.h
//  fidelio
//
//  Created by Michael Pfister on 2/8/14.
//  Copyright (c) 2014 Michael Pfister. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *transmitButton;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion; // Define settings for transmitter beacon
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager; // Control the transmitter

- (IBAction)transmitButton:(id)sender;

@end
