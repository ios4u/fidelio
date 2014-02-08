//
//  ViewController.m
//  fidelio
//
//  Created by Michael Pfister on 2/8/14.
//  Copyright (c) 2014 Michael Pfister. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

bool transmitting = false;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // init beacon
    [self initBeacon];
    [self.uuidLabel setText:self.beaconRegion.proximityUUID.UUIDString];
    [self.majorLabel setText:[NSString stringWithFormat:@"%@", self.beaconRegion.major]];
    [self.minorLabel setText:[NSString stringWithFormat:@"%@", self.beaconRegion.minor]];
    [self.identityLabel setText:self.beaconRegion.identifier];
    
    // update the labels
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBeacon {
    // TODO: make this work for any mac seamlessly
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"3B5B69EC-0D4A-4B0D-8A9C-D9073B0CB062"]; // generated with uuidgen
    
    // TODO don't hardcode the major minor etc?
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"io.pfista.fidelio"];
    
}

-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered on ");
        transmitting = true;
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        [self.transmitButton setTitle:@"Stop Transmission" forState:UIControlStateNormal];
        
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        // TODO: ask user to turn bluetooth on
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
        [self.transmitButton setTitle:@"Transmit unlock request" forState:UIControlStateNormal];
    }
}

- (IBAction)transmitButton:(id)sender {
    if (transmitting) {
        NSLog(@"Button pressed");
        self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:[NSNumber numberWithBool:YES]}];

        [self.transmitButton setTitle:@"Stop Transmission" forState:UIControlStateNormal];
    }
}

@end
