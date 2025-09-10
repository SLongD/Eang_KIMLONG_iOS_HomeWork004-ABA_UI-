//
//  CustomView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/10/25.
//

import SwiftUI

func customScrollView<Data: Identifiable, Content: View>(
    items: [Data],
    @ViewBuilder content: @escaping (Data) -> Content
) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 15) {
            ForEach(items) { item in
                content(item)
            }
        }
    }
    .padding([.vertical, .leading])
    .frame(maxWidth: .infinity)
    .background(.white.opacity(0.5))
    .cornerRadius(15)
}


//func customScrollImageView<>() -> some View {
//    ScrollView(.horizontal, showsIndicators: false){
//        LazyHStack(spacing: 15){
//            ForEach(serviceList){ item in
//                VStack(alignment: .leading){
//                    Image(item.bgUrl)
//                        .resizable()
//                        .frame(width: 80, height: 80)
//                        .cornerRadius(20)
//                        .padding(4)
//                        .background(.white)
//                        .cornerRadius(20)
//                    Group{
//                        Text(item.title)
//                        Text("Services")
//                    }
//                    .font(.system(size: 16))
//                    .foregroundStyle(.white)
//                }
//            }
//        }
//    }
//    .padding()
//    .frame(maxWidth: .infinity)
//    .background(.white.opacity(0.5))
//    .cornerRadius(15)
//}
