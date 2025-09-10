//
//  SheetView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/9/25.
//

import SwiftUI
import PhotosUI
import Foundation

let bgImage = [
    BackgroundImageUrl(bgUrl: "Bayon", title: "Bayon"),
    BackgroundImageUrl(bgUrl: "BonTeaySrey", title: "BonTeaySrey"),
    BackgroundImageUrl(bgUrl: "Cute Pets", title: "Petties"),
    BackgroundImageUrl(bgUrl: "Khmer Heritage", title: "Heritage"),
    BackgroundImageUrl(bgUrl: "Moon Night", title: "Moon"),
    BackgroundImageUrl(bgUrl: "Train", title: "Forest"),
    BackgroundImageUrl(bgUrl: "Sunset", title: "Sunset Lover"),
]
let textLabel = ["Themes", "Dark Mode", "Homescreen"]


struct SheetView: View {
    @State private var selected : [UUID : Bool] = [:]
    @State private var selectedId: UUID? = nil
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @ObservedObject var bgChanger : BackgroundImageManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Appearance")
                .font(.title)
                .bold()
            HStack{
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(textLabel.indices, id: \.self){ index in
                            Button(action: {
                                
                            }){
                                Text(textLabel[index])
                                    .foregroundStyle(Color.gray)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 20)
                                    .background(.white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                }
            }
            .frame(height: 100)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    ForEach(bgImage){ items in
                        VStack{
                            Button(action:{
                                bgChanger.id = items.id
                                bgChanger.backgroundImageUrl = items.bgUrl
                            }){
                                Image(items.bgUrl)
                                    .resizable()
                                    .frame(width: 140, height: 230)
                                    .cornerRadius(20)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(bgChanger.id == items.id ? Color.blue : Color.white,style: StrokeStyle(lineWidth: 3))
                                    }
                            }
                            Text(items.title)
                                .font(.title3)
                                .foregroundStyle(Color.black)
                        }
                    }
                    
                    VStack{
                        VStack{
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color(.systemGray))
                        }
                        .frame(width: 140, height: 230)
                        .cornerRadius(20)
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue,style: StrokeStyle(lineWidth: 3, dash: [4,4]))
                        }
                        Text("Add Image")
                            .font(.title3)
                            .foregroundStyle(Color.black)
                    }
                    
                }
            }
            .onAppear {
                // restore background when app launches
                if let savedId = selectedId,
                   let savedItem = bgImage.first(where: { $0.id == savedId }) {
                    bgChanger.backgroundImageUrl = savedItem.bgUrl
                }
            }
            .frame(height: 280)
        }
        .preferredColorScheme(.light)
        
    }
}


//#Preview {
//    @StateObject  var v : BackgroundImageManager = BackgroundImageManager()
//    SheetView(bgChanger: v)
//}
