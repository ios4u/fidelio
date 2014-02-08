//
//  ViewController.m
//  fidelio
//
//  Created by Michael Pfister on 2/8/14.
//  Copyright (c) 2014 Michael Pfister. All rights reserved.
//  Code adapted from tutorial at http://www.devfright.com/ibeacons-tutorial-ios-7-clbeaconregion-clbeacon/
//

#import "ViewController.h"

@interface ViewController ()

@end

bool transmitting = false;
bool listening = false;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // init beacon
    [self initBeacon];
    // update the labels
    [self.uuidLabel setText:self.beaconRegion.proximityUUID.UUIDString];
    [self.majorLabel setText:[NSString stringWithFormat:@"%@", self.beaconRegion.major]];
    [self.minorLabel setText:[NSString stringWithFormat:@"%@", self.beaconRegion.minor]];
    [self.identityLabel setText:self.beaconRegion.identifier];
    [self.rssiLabel setText:0];
    
    // Set up receiving stuff
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    
    
    // Temporarily hack due to laziness (I don't want to walk 20ft)
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
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
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:1 minor:1 identifier:@"io.pfista.fidelio"];
    
}

- (void)initRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"3B5B69EC-0D4A-4B0D-8A9C-D9073B0CB062"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"io.pfista.fidelio"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    self.rssiLabel.text = [NSString stringWithFormat:@"%li", (long)beacon.rssi];
}


-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered on ");
        transmitting = true;
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        [self.transmitButton setTitle:@"Stop Transmission" forState:UIControlStateNormal];
        
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
        [self.transmitButton setTitle:@"Transmit unlock request" forState:UIControlStateNormal];
    }
}

- (IBAction)transmitButton:(id)sender {
    if (transmitting) {
        NSLog(@"Stopping transmission");
        [self.peripheralManager stopAdvertising];
        [self.transmitButton setTitle:@"Transmit unlock request" forState:UIControlStateNormal];
        
    } else {
        NSLog(@"Starting transmission");
        self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:[NSNumber numberWithBool:YES]}];
        // TODO only change title if we know for sure it was enabled in settings...
        [self.transmitButton setTitle:@"Stop Transmission" forState:UIControlStateNormal];

    }
    
    transmitting = !transmitting;
}



@end
