//
//  NewHomeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/8.
//

import SwiftUI
import SwiftUICharts
import Progress_Bar

struct HomeView: View {
    @ObservedObject var myData = userData
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var value: Int? = 0

    var startAngle = -90.0
    @State var progress : Double = 0.97
        
    @State var zoomLarge = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                HStack{
                    Text("My Health")
                        .font(.system(size: 28))
                        .padding(30)
                        .foregroundColor(Color("HomeTitleColor"))
                    Spacer()

                    NavigationLink {
                        DeviceDictView()
                    } label: {
                        Capsule()
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                            .padding(.trailing, 30)
                            .opacity(0.05)
                            .foregroundColor(.black)
                            .overlay(Text(userData.isDeviceConnected ? userData.currentDeviceName : "点击连接设备") .padding(.trailing, 30).foregroundColor(.black))
                    }
                }
                
                VStack{
                    HStack{
                        Text("Health Data")
                            .font(.system(size: 17))
                            .foregroundColor(Color("HomeTitleColor"))
                            .padding(.leading, 30)
                        
                        Spacer()
                        
                        Button {
                            myData.isOnHand.toggle()
                        } label: {
                            Text("Details")
                        }

                        Image(systemName: "arrow.right")
                            .padding(.trailing, 30)
                            .foregroundColor(Color("HomeTitleColor"))
                    }
                    
                    ZStack{
                        Image("HomeCard")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, -30)
                            .padding(.top, -14)
                        
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    HStack(){
                                        Image("PinkStick")
                                        VStack(alignment: .leading){
                                            Text("HR")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(hex: "#9797a8"))
                                            HStack{
                                                Image("RedHearts")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                      
                                                
                                                Text("\(Int(myData.realTimeHR.last!))")
                                                    .font(.system(size: 22))
                                                    .foregroundColor(Color("HomeTitleColor"))
                                                
                                                
                                                Text("beats")
                                                    .foregroundColor(Color(hex: "#9797a8"))
                                                    .font(.system(size: 11))
                                                    .padding(.bottom, -8)
                                            }
                                            .padding(.top, -10)
                                        }
                                    }
                                    .padding(.bottom, 12)
                                    HStack{
                                        Image("BlueStick")
                                        VStack(alignment: .leading){
                                            Text("HRV")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(hex: "#9797a8"))
                                            HStack(){
                                                Image("WhiteBell")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                      
                                                
                                                Text("\(Int(myData.realTimeHRV.last!))")
                                                    .font(.system(size: 22))
                                                    .foregroundColor(Color("HomeTitleColor"))
        
                                                Text("ms")
                                                    .foregroundColor(Color(hex: "#9797a8"))
                                                    .font(.system(size: 11))
                                                    .padding(.bottom, -8)
                                            }
                                            .padding(.top, -10)
                                        }
                                    }
                                }
                                .padding(.leading, 24.5)
                                
                                Spacer()
                                
                                ZStack {
                                    Circle()
                                        .stroke(Color(hex: "#e8ecff"), lineWidth: 4)
                                    RingShape(progress: progress, thickness: 12)
                                        .fill(AngularGradient(gradient: Gradient(colors: [Color(hex: "#464ae1"), Color(hex: "#6f8fea")]), center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * progress + startAngle)))
                                        .shadow(color: Color(hex: "#474AD9"), radius: 3, x:3, y: 3)
                                    
                                    RingDot(progress: progress, thickness: 6)
                                        .fill(Color.white)
                                        .shadow(color: Color(hex: "#474AD9"), radius: 6, y: 3)
                                    
                                    VStack{
                                        Text("\(Int(myData.realTimeSpo2.last! * 100))")
                                            .font(.system(size: 28))
                                            .foregroundColor(Color(hex: "#474ad9"))
                                        
                                        Text("Spo2")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(hex: "#9797a8"))
                                    }

                                }
                                .frame(width: 112, height: 112, alignment: .center)
                                .padding(.trailing, 29)
                                .animation(Animation.easeInOut(duration: 1.0),value: progress)
                           }
                            .padding(.bottom, 12)
                            Image("CardDivider")
                                .padding(.bottom, 16)

                            
                            HStack(spacing: 50){
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Loss")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("HomeTitleColor"))
                                    LinearProgress(percentage: myData.lossRate / 100.0, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#ced8ff"), Color(hex: "#ced8ff")], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 56, height: 4)
                                    Text("\(myData.lossRate / 100.0)%")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color(hex: "#9797a8"))
                                }
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Mistake")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("HomeTitleColor"))
                                    LinearProgress(percentage: myData.mistakeRate / 100.0, backgroundColor: Color(hex: "#ffe7ee"), foregroundColor: LinearGradient(colors: [Color(hex: "#ffa6c1"), Color(hex: "#ff4d84")], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 56, height: 4)
                                    Text("\(myData.mistakeRate / 100.0)%")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color(hex: "#9797a8"))
                                }
                                Image("OnHand")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(2)
                                    .frame(width: 40)
                                    .background(
                                        ZStack{
                                            Circle().foregroundColor(Color(hex: "#d0d8fc"))
                                                .frame(width: 100)
                                                .padding(-10)
                                            Circle().foregroundColor(Color(hex: "#f4f6fc"))
                                                .frame(width: 100)
                                                .padding(-5)
                                        })
                                    .opacity(myData.isOnHand ? 1 : 0.3)
                                    .scaleEffect(zoomLarge ? 10 : 1)
                                    .onChange(of: myData.isOnHand, perform: { newValue in
                                        withAnimation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0).repeatCount(1)){
                                            zoomLarge.toggle()
                                            print("[zoomLarge]", zoomLarge)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                withAnimation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0).repeatCount(1)){
                                                    zoomLarge.toggle()
                                                }
                                            }
                                        }
                                    })
                            }
                            .padding(.bottom, 50)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            
            VStack{
                HStack{
                    Text("RealTime Data")
                        .font(.system(size: 17))
                        .foregroundColor(Color("HomeTitleColor"))
                        .padding(.leading, 30)
                    
                    Spacer()
                    
                    Button {

                    } label: {
                        Text("Details")
                    }

                    Image(systemName: "arrow.right")
                        .padding(.trailing, 30)
                        .foregroundColor(Color("HomeTitleColor"))
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        CardView {
                            Text("Spo2")
                                .foregroundColor(Color("HomeTitleColor"))
                                .font(.system(size: 24))
                                .padding(10)
                            ChartLabel("\(myData.realTimeHR.last!)", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                      
                            ChartGrid {
                                LineChart()
                            }
                        }
                        .data([8,23,54,32,12,37,7,23])
                        .chartStyle(ChartStyle(backgroundColor: .clear,
                                               foregroundColor: ColorGradient(.white, .red)))
                        .frame(width: 120,height: 200)
                        
                        CardView {
                            Text("HR")
                                .foregroundColor(Color("HomeTitleColor"))
                                .font(.system(size: 24))
                                .padding(10)
                            ChartLabel("\(myData.realTimeHR.last!)", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                      
                            ChartGrid {
                                LineChart()
                            }
                        }
                        .data([8,23,54,32,12,37,7,23])
                        .chartStyle(ChartStyle(backgroundColor: .clear,
                                               foregroundColor: ColorGradient(.pink.opacity(0.5), .red)))
                        .frame(width: 120,height: 200)
                        
                        CardView {
                            Text("HRV")
                                .foregroundColor(Color("HomeTitleColor"))
                                .font(.system(size: 24))
                                .padding(10)
                            ChartLabel("\(myData.realTimeHR.last!)", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                      
                            ChartGrid {
                                LineChart()
                            }
                        }
                        .data([8,23,54,32,12,37,7,23])
                        .chartStyle(ChartStyle(backgroundColor: .clear,
                                               foregroundColor: ColorGradient(.blue.opacity(0.5), .blue)))
                        .frame(width: 120,height: 200)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 5)
                }
            }
            .padding(.top, -20)
            Spacer(minLength: 60)
        }
        .background(Color("HomeBgColor").ignoresSafeArea())
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RingShape: Shape {
    var progress: Double = 0.0
    var thickness: CGFloat = 12.0
    var startAngle: Double = -90.0

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {

    var path = Path()

        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: min(rect.width, rect.height) / 2.0,startAngle: .degrees(startAngle),endAngle: .degrees(360 * progress + startAngle), clockwise: false)

    return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
}

struct RingDot: Shape {
    var progress: Double = 0.0
    var thickness: CGFloat = 12.0
    var startAngle: Double = -90.0

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {

    var path = Path()

        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: min(rect.width, rect.height) / 2.0,startAngle: .degrees(360 * progress + startAngle - 0.1),endAngle: .degrees(360 * progress + startAngle), clockwise: false)

    return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
