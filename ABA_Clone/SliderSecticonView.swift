//
//  SliderSecticonView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/10/25.
//

import SwiftUI

struct SliderSecticonView: View {
    @Binding var selectedTab : Int
    @State private var autoAdvance = true
    private let autoAdvanceInterval: TimeInterval = 3.0
    let imageUrl = [
        ImageUrl(url: "ABA-promote_EON"),
        ImageUrl(url: "ABA_Promote3"),
        ImageUrl(url: "ABA_Promote2"),
    ]
    
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                ForEach(0..<imageUrl.count, id: \.self) { index in
                    let item = imageUrl[index]
                    VStack(alignment: .leading, spacing: 35) {
                        VStack {
                            Image(item.url)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .clipped()
                                .cornerRadius(20)
                        }
                        
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(maxWidth: .infinity)
            .tint(.blue)
            .onReceive(
                Timer.publish(
                    every: autoAdvance ? autoAdvanceInterval : 999_999,
                    on: .main,
                    in: .common
                ).autoconnect()
            ) { _ in
                if autoAdvance && !imageUrl.isEmpty {
                    withAnimation {
                        selectedTab = selectedTab < imageUrl.count - 1 ? selectedTab + 1 : 0
                    }
                }
            }
        }
        .frame(height: 200)
    }
}


func customTextView(text: String) -> some View {
    Text(text)
        .font(.system(size: 20))
        .foregroundStyle(.white)
}
