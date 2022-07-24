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

    func scanClick() {
        print("开始扫描")
        BluetoothManager.sharedInstance.startScan { (peripheral) in
            self.syncData()
        }
    }
    
    func stopClick() {
        print("停止扫描")
        BluetoothManager.sharedInstance.stopScan()
        syncData()
    }
    
    func syncData() -> Array<CBPeripheral>{
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
    @EnvironmentObject var userData: UserData

    var name: String?
    var uuid: String?
    @State var state: CBPeripheralState
    
    func getState(state: CBPeripheralState) -> String{
        switch state{
        case .connected: return("已连接")
        case .connecting: return("连接中")
        case .disconnected: return("未连接")
        case .disconnecting: return("断开中")
        }
    }
    
    var body: some View{
        HStack {
            VStack(alignment: .leading){
                if let name = self.name {
                    Text(self.name!)
                }
                if let uuid = self.uuid {
                    Text(self.uuid!)
                        .font(.system(size: 8))
                }
            }
            Spacer()
            Button {
                if let uuid = self.uuid {
                    userData.currDevice.uuid = UUID(uuidString: self.uuid!)
                }
                if let name = self.name {
                    userData.currDevice.name = self.name
                }
                ConnectionAdapter.sharedInstance().connect(userData.currDevice)
                print(FindDevice().syncData().filter{ cell -> Bool in
                    return cell.name == self.name
                })
            } label: {
                Circle()
                    .foregroundColor(.red)
            }

            Text(getState(state:self.state))
            
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
            Button {
                findDevice.scanClick()
                peripheralArray = findDevice.syncData()
                print(peripheralArray)
            } label: {
                Text("开始扫描")
            }
            .onAppear {
                findDevice.scanClick()
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    findDevice.scanClick()
                    peripheralArray = findDevice.syncData()
                    print(peripheralArray)
                }
                peripheralArray = findDevice.syncData()
            }
            
            List(peripheralArray, id: \.self){ cell in
                SelectDeviceCell(name: cell.name==nil ? "无名字": cell.name!, uuid: cell.identifier.uuidString, state: cell.state)
            }
        }
    }
}

struct FindDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        FindDeviceView()
    }
}
