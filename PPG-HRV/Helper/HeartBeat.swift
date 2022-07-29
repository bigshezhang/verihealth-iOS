//
//  HeartBeat.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/29.
//

import SwiftUI

struct HeartBeat: View {
    @State var heartBeat = false
    
    var body: some View {
        ZStack {
            
            Image(systemName: "heart")
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFill()
                .foregroundColor(.pink)
                .scaleEffect(heartBeat ? 1 : 0.5)
                .opacity(heartBeat ? 0.6 : 0)
        }
        .frame(width: 30, height: 30)
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0).repeatForever(autoreverses: true)) {
                    heartBeat.toggle()
            }
        }
    }
}

struct HeartBeat_Previews: PreviewProvider {
    static var previews: some View {
        HeartBeat()
    }
}
