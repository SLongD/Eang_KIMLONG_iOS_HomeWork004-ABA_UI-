//
//  BalanceView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/10/25.
//

import SwiftUI
struct BalanceCardView: View {
    @Binding var blurValue: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("$10000")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .blur(radius: blurValue)
                Button(action: {
                    blurValue = blurValue == 0 ? 4 : 0
                }) {
                    Image(systemName: "eye.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.blue.opacity(0.7))
                        .cornerRadius(10)
                }
                Spacer()
            }
            HStack(spacing: 35) {
                Text("Default")
                    .padding(2)
                    .padding(.horizontal, 5)
                    .background(.blue.opacity(0.7))
                    .cornerRadius(5)
                Text("Saving")
                Spacer()
            }
            HStack {
                HStack(spacing: 10) {
                    Image("receive-circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Receive money")
                        .foregroundStyle(.white)
                }
                HStack(spacing: 10) {
                    Image("send-circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Send money")
                        .foregroundStyle(.white)
                }
            }
        }
        .padding()
        .frame(height: 200)
        .background(.white.opacity(0.5))
        .cornerRadius(15)
    }
}

