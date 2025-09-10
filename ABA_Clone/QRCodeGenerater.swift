//
//  QRCodeGenerater.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/9/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()
let qrcodeString = "00020101021130450016abaakhppxxx@abaa01090054769400208ABA Bank40390006abaP2P0112E08A90EE013102090054769405204000053038405802KH5912EANG KIMLONG6010Phnom Penh6304807A"
struct QRCodeGenerater: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack(){
            HStack{
                Image("ABALogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 30)
                Text("QR")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundStyle(.white)
            }
            
            HStack(alignment:.bottom){
                Text("   ប្រើ QR នេះដើម្បីទទួលបានប្រាក់មិត្តភក្ក ឬ\n ផ្ទេរប្រាក់ពីអេបធនគារផ្សេងទៀតរបស់អ្នក")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.blue)
            }
            Image("KHQR")
                .resizable()
                .frame(width: 310, height: 400)
                .overlay{
                    VStack(alignment: .leading, spacing: 30){
                        VStack(alignment: .leading){
                            Text("EANG KIMLONG")
                            Text("$ 0.00")
                        }
                        .bold()
                        Image(uiImage: UIImage(data: generateQR(text: qrcodeString)!)!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 210, height: 210)
                    }
                    .padding(.top, 40)
                }
            Button(action: {
                
            }){
                HStack{
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(.systemGreen).opacity(0.7))
                    Text("បញ្ចូលចំនួនទឹកប្រាក់")
                        .foregroundStyle(Color(.systemGreen).opacity(0.7))
                }
                .padding(.vertical,10)
                .padding(.horizontal,50)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGreen).opacity(0.7), lineWidth: 1)
                }
            }
            HStack{
                Text("ទទួលទៅ:")
                    .foregroundStyle(.white)
                Text("002 330 110")
                    .foregroundStyle(Color(.systemGreen).opacity(0.7))
            }
            HStack{
                Spacer()
                Button(action: {
                    
                }){
                    VStack{
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(Color(.systemGray2).opacity(0.3))
                            .clipShape(Circle())
                        Text("ទាញយក")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
                Button(action: {
                    
                }){
                    VStack{
                        Image(systemName: "camera.viewfinder")
                        
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color(.systemGray2).opacity(0.3))
                            .clipShape(Circle())
                        Text("ថតអេក្រង់")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
                Button(action: {
                    
                }){
                    VStack{
                        Image(systemName: "link")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color(.systemGray2).opacity(0.3))
                            .clipShape(Circle())
                        Text("ផ្ញើលីង")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
            }
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .overlay(alignment: .topTrailing){
            Button(action: {
                isPresented.toggle()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .padding()
            }
            .padding(.top, -30)
        }
    }
    
    
    
    private func generateQR(text: String) -> Data? {
        let filter = CIFilter.qrCodeGenerator()
        guard let data = text.data(using: .ascii, allowLossyConversion: false) else { return nil }
        filter.message = data
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
}




