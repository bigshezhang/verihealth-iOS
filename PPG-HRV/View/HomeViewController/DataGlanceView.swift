//
//  DataGlanceView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import SwiftUICharts
import Progress_Bar

struct DataGlanceView: View {
    @ObservedObject var myData = userData
    var startAngle = -90.0
    @State var progress : Double = 0.97
        
    @State var toastState = false
    var body: some View {
        VStack{
            HStack{
                Text("Health Data")
                    .font(.system(size: 17))
                    .foregroundColor(Color("HomeTitleColor"))
                    .padding(.leading, 30)
                
                Spacer()
                
                NavigationLink {
                    TodayView()
                } label: {
                    Text("Today")
                        .foregroundColor(Color(hex: "#6f8fea"))
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
                              
                                        
                                        Text((myData.realTimeHR.count == 2) ? " --" : "\(Int(myData.realTimeHR.last!))")
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
                              
                                        
                                        Text((myData.realTimeHRV.count == 2) ? " --" : "\(Int(myData.realTimeHRV.last!))")
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
                            RingShape(progress: Double(myData.realTimeSpo2.last!) / 100.0, thickness: 12)
                                .fill(AngularGradient(gradient: Gradient(colors: [Color(hex: "#464ae1"), Color(hex: "#6f8fea")]), center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * progress + startAngle)))
                                .shadow(color: Color(hex: "#474AD9"), radius: 3, x:3, y: 3)
                                .animation(.spring(), value: myData.realTimeSpo2.last!)
                            
                            RingDot(progress: Double(myData.realTimeSpo2.last!) / 100.0, thickness: 6)
                                .fill(Color.white)
                                .shadow(color: Color(hex: "#474AD9"), radius: 6, y: 3)
                                .animation(.spring(), value: myData.realTimeSpo2.last!)

                            
                            VStack{
                                Text((myData.realTimeSpo2.count == 2) ? "--" : "\(Int(myData.realTimeSpo2.last!))")
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
                            LinearProgress(percentage: myData.lossRate, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#ced8ff"), Color(hex: "#ced8ff")], startPoint: .leading, endPoint: .trailing))
                                .frame(width: 56, height: 4)
                            Text("\(String(format: "%.1f", myData.lossRate * 100))%")
                                .font(.system(size: 11))
                                .foregroundColor(Color(hex: "#9797a8"))
                        }
                        VStack(alignment: .leading, spacing: 5){
                            Text("Mistake")
                                .font(.system(size: 14))
                                .foregroundColor(Color("HomeTitleColor"))
                            LinearProgress(percentage: myData.mistakeRate, backgroundColor: Color(hex: "#ffe7ee"), foregroundColor: LinearGradient(colors: [Color(hex: "#ffa6c1"), Color(hex: "#ff4d84")], startPoint: .leading, endPoint: .trailing))
                                .frame(width: 56, height: 4)
                            Text("\(String(format: "%.1f", myData.mistakeRate * 100))%")
                                .font(.system(size: 11))
                                .foregroundColor(Color(hex: "#9797a8"))
                        }
                        Image("OnHand")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.15)
                            .frame(width: 40)
                            .background(
                                ZStack{
                                    Circle().foregroundColor(Color(hex: "#d0d8fc"))
                                        .scaleEffect(2.15)
                                    
                                    Circle().foregroundColor(Color(hex: "#f4f6fc"))
                                        .scaleEffect(1.8)
                                })
                            .opacity(myData.isOnHand ? 1 : 0.3)
                            .animation(.easeInOut(duration: 0.3), value: myData.isOnHand)
                            .onChange(of: myData.isOnHand, perform: { newValue in
                                if myData.isOnHand{
                                    toastState.toggle()
                                }
                            })
                    }
                    .padding(.bottom, 50)
                }
            }
            .padding(.horizontal, 30)
        }
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

struct DataGlanceView_Previews: PreviewProvider {
    static var previews: some View {
        DataGlanceView()
    }
}
