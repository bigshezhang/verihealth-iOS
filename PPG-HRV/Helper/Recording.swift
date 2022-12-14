import SwiftUI

struct Recording: View {
//    @Binding var isScaning: Bool
    @State var recording = false
    
    var body: some View {
        ZStack {
            
            Circle()
            .foregroundColor(.blue)
            .frame(width: 160, height: 160)
            .scaleEffect(recording ? 1 : 0.5)
            .opacity(recording ? 0.6 : 0)
            
            Circle()
            .foregroundColor(.blue)
            .frame(width: 160, height: 160)
            .scaleEffect(recording ? 1.2 : 0.5)
            .opacity(recording ? 0.6 : 0)
            
            Circle()
            .foregroundColor(.blue)
            .frame(width: 160, height: 160)
            .scaleEffect(recording ? 1.4 : 0.5)
            .opacity(recording ? 0.6 : 0)
        }
        
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0).repeatForever(autoreverses: true)) {
                    recording.toggle()
            }
        }
    }
}

//struct Recording_Previews: PreviewProvider {
//    static var previews: some View {
//        Recording(isScaning: .constant(true))
//    }
//}
