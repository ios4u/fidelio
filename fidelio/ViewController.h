//
//  ViewController.h
//  fidelio
//
//  Created by Michael Pfister on 2/8/14.
//  Copyright (c) 2014 Michael Pfister. All rights reserved.
//

@import UIKit;
@import CoreBluetooth;
@import CoreLocation;
#import <Parse/Parse.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *transmitButton;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion; // Define settings for transmitter beacon

// Used for transmitting
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager; // Control the transmitter

// Used for receiving
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)transmitButton:(id)sender;

@end
