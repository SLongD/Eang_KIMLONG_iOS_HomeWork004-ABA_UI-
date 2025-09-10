//
//  HeaderView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/10/25.
//
import SwiftUI
struct HeaderView: View {
    @Binding var qrCodeShowSheet: Bool
    
    var body: some View {
       
        HStack{
            HStack {
                Image("AngkorWat")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hello, Kimlong")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("View Profile")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }
            Spacer()
            HStack(spacing: 25) {
                Image("notificatioIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
                Button(action: { qrCodeShowSheet = true }) {
                    Image("IconGoToQR")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        
    }
}
//#Preview {
//    @State var qrCodeShowSheet: Bool = false
//    HeaderView(qrCodeShowSheet: $qrCodeShowSheet )
//}
