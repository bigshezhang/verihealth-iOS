//
//  NewHomeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/8.
//

import SwiftUI
import SwiftUICharts
import Progress_Bar

struct NewHomeView: View {
    @ObservedObject var MyData = userData
    @EnvironmentObject var viewRouter: ViewRouter
    
    var startAngle = -90.0
    @State var progress : Double = 0.97
    
    @State var HR = Int()
    @State var HRV = Int()
    
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
                                      
                                                
                                                Text("\(HR + 100)")
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
                                      
                                                
                                                Text("\(HRV + 100)")
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
                                        Text("\(Int(progress * 100))")
                                            .font(.system(size: 28))
                                            .foregroundColor(Color(hex: "#474ad9"))
                                        
                                        Text("So2")
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
                                    LinearProgress(percentage: 0.2, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#ced8ff"), Color(hex: "#ced8ff")], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 56, height: 4)
                                    Text("20%")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color(hex: "#9797a8"))
                                    
                                }
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Mistake")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("HomeTitleColor"))
                                    LinearProgress(percentage: 0.2, backgroundColor: Color(hex: "#ffe7ee"), foregroundColor: LinearGradient(colors: [Color(hex: "#ffa6c1"), Color(hex: "#ff4d84")], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 56, height: 4)
                                    Text("20%")
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
                    HStack(spacing: -12){
                        Image("OrangeCard")
                    
                        Image("BlueCard")
                        
                        Image("PinkCard")
                    }
                    .padding(.leading)
                }
            }
            .padding(.top, -20)
            
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
struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
            .environmentObject(ViewRouter())
    }
}
