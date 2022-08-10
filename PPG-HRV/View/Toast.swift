//
//  Toast.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import AlertToast
import GIFImage
import SwiftyGif

struct Toast: View {
    @State private var showToast = false
    var body: some View {
        VStack{

                   Button("Show Toast"){
                        showToast.toggle()
                   }
            
            ConnectedToast()
                .frame(width: 200,height: 100)
        }
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: "Message Sent!")
            
        }
        
//        GIFImage(gifName: "Connected.gif")
        
    }
}

struct ConnectedToast : UIViewRepresentable{

    typealias UIViewType = UIImageView
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: UIImage.gif(asset: "Connected"))
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        
    }
    
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
    }
}
