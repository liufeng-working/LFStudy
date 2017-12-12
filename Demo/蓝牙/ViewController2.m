//
//  ViewController2.m
//  蓝牙
//
//  Created by 刘丰 on 2017/11/29.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController2.h"
#import <CoreBluetooth/CoreBluetooth.h>


/**
 1.建立中心管家
 2.扫描外部设备
 3.连接外部设备
 4.扫描连接到的外部设备的服务
 4.
 */

@interface ViewController2 ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property(nonatomic,strong) CBCentralManager *centralManager;

@property(nonatomic,strong) CBPeripheral *peripheral;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 1.建立中心管家
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}

#pragma mark -
#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {// 在开机状态下才进行扫描
        // 2.扫描外部设备
        [central scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    // 3.连接外部设备
    NSLog(@"peripheral -> %@", peripheral);
    peripheral.delegate = self;
    self.peripheral = peripheral;
    [central connectPeripheral:peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // 4.扫描服务
    NSLog(@"connection -> %@", peripheral);
    [peripheral discoverServices:nil];
}

#pragma mark -
#pragma mark - CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"%s", __func__);
    for (CBService *service in peripheral.services) {
        
        // 过滤服务 FEE7
        if ([service.UUID.UUIDString isEqualToString:@"FEE7"]) {
            // 扫描服务中的所有特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    // 扫描特征里面的所有特征描述
    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        [peripheral readValueForCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        // 读取特征描述
        [peripheral readValueForDescriptor:descriptor];
    }
}

@end
