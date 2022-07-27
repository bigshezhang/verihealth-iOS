//
//  BluetoothScanner.swift
//  BluetoothTest
//
//  Created by Dalibor Andjelkovic on 22.09.20.
//

import Foundation
import CoreBluetooth
import Combine

class BluetoothScanner: NSObject, ObservableObject {
    @Published var isScanningPublisher: Bool = false
    public var results = [String]()
    let central: CBCentralManager = {
        CBCentralManager()
    }()

    override init() {
        super.init()
        central.delegate = self
    }

    public func startScan() {
        isScanningPublisher = true
        results = []
        central.scanForPeripherals(withServices: nil , options: nil)
    }
    
    public func stop() {
        isScanningPublisher = false
        if central.isScanning {
            central.stopScan()
        }
    }

}

extension BluetoothScanner: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(#function)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        results.append("""
        \(peripheral.name ?? "")
        \(peripheral.identifier)
        \(peripheral.services?.debugDescription ?? "No Services found ")
        """)
        store.peripherals = results
        
        print(store.peripherals)
    }
}

class Store: ObservableObject {
    @Published var peripherals : [String] = []
}

var store = Store()
