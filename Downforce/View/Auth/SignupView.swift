//
//  SignupView.swift
//  Downforce
//
//  Created by Ayush Bhople on 29/03/26.
//

import SwiftUI

struct SignupView: View {
    
//    private let glowPosition = CGPoint(x: 275, y: 215)
//    private let distortionPosition = CGPoint(x: 400, y: 400)
//    private let distortionSize = CGSize(width: 730, height: 5)
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("19")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                    .ignoresSafeArea()
                
//                HeatDistortionViewup(imageName: "19")
//                    .frame(width: distortionSize.width, height: distortionSize.height)
//                    .position(
//                        x: geo.size.width * 0.75,
//                        y: geo.size.height * 0.65
//                    )
                
                LinearGradient(colors: [
                    Color.black.opacity(1),
                    Color.black.opacity(0.6),
                    Color.black.opacity(0.0)
                ], startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
        }
    }
    
}


//struct HeatDistortionViewup: View {
//    let imageName: String
//    @State private var start = Date.now
//    
//    var body: some View {
//        GeometryReader { geo in
//            TimelineView(.animation) { t1 in
//                let elapsed = start.distance(to: t1.date)
//                
////                Rectangle()
////                    .fill(.blue)
//                Image(imageName)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(
//                        width: UIScreen.main.bounds.width,
//                        height: UIScreen.main.bounds.height
//                    )
//                    .offset(
//                        x: -(geo.frame(in: .global).minX),
//                        y: -(geo.frame(in: .global).minY)
//                    )
//                    .visualEffect { content, proxy in
//                        content
//                            .distortionEffect(
//                                ShaderLibrary.heatDistortion(
//                                    .float(elapsed),
//                                    .float2(proxy.size)
//                                ),
//                                maxSampleOffset: CGSize(width: 20, height: 20)
//                            )
//                    }
//                    .clipped()
//            }
//        }
//    }
//}

#Preview {
    SignupView()
}
