//
//  FindDeviceView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import BaseFramework
import BleFramework
import CoreSDK


var currDevice = VsDevice()

class FindDevice {
    var peripheralArray: [CBPeripheral] = []

    func startScan() {
        print("开始扫描")
        BluetoothManager.sharedInstance.startScan { (peripheral) in
            self.syncData()
        }
    }
    
    func stopScan() {
        print("停止扫描")
        BluetoothManager.sharedInstance.stopScan()
        syncData()
    }
    
    func syncData() -> [CBPeripheral]{
        self.peripheralArray = BluetoothManager.sharedInstance.peripheralArray as! [CBPeripheral]
        return peripheralArray
    }
    
    func viewDidLoad(){
         BluetoothManager.sharedInstance.startScan { (peripheral) in
                   self.syncData()
        }
    }
}

struct SelectDeviceCell: View{
    var name: String
    var uuid: String
    var body: some View{
        VStack{
            Text(name)
            Text(uuid)
        }
    }
}

struct FindDeviceView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var peripheralArray: [CBPeripheral] = []
    @State var findDevice = FindDevice()
    
    var body: some View {
        VStack{
            List(peripheralArray, id: \.self) { cell in
                SelectDeviceCell(name: cell.name!, uuid: cell.identifier.uuidString)
            }
        }
        .onAppear {
            findDevice.startScan()
            findDevice.startScan()
            peripheralArray = findDevice.syncData()
            print(peripheralArray)
        }
        Button {
            findDevice.startScan()
        } label: {
            Text("233")
        }

    }
}

struct FindDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        FindDeviceView()
    }
}
