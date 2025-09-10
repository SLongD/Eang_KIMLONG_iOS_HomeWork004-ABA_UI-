//
//  ContentView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/8/25.
//

import SwiftUI

let imageUrl = [
    ImageUrl(url: "ABA-promote_EON"),
    ImageUrl(url: "ABA_Promote3"),
    ImageUrl(url: "ABA_Promote2"),
]

let staffList = [
    Person(name: "Kimlong", status: "KL"),
    Person(name: "Chetra", status: "CT"),
    Person(name: "Phalling", status: "PL"),
    Person(name: "Sovanara", status: "SV"),
    Person(name: "Kimson", status: "KS"),
    Person(name: "Mengsea", status: "MS"),
]
let serviceList = [
    BackgroundImageUrl(bgUrl: "U&Me", title: "U&Me"),
    BackgroundImageUrl(bgUrl: "metfonelogo", title: "Metfone"),
    BackgroundImageUrl(bgUrl: "VET", title: "VET"),
    BackgroundImageUrl(bgUrl: "cambolink", title: "CamBoLink"),
    BackgroundImageUrl(bgUrl: "manulife", title: "Metfone"),
]
let govermentServiceList = [
    BackgroundImageUrl(bgUrl: "NSSF", title: "U&Me"),
    BackgroundImageUrl(bgUrl: "PPSHV", title: "Metfone"),
    BackgroundImageUrl(bgUrl: "general", title: "VET"),
    BackgroundImageUrl(bgUrl: "foreigner", title: "CamBoLink"),
    BackgroundImageUrl(bgUrl: "publicWork", title: "Metfone"),
]


struct ContentView: View {
    @State private var blurValue: CGFloat = 0
    @State private var selectedTab = 0
    @State private var autoAdvance = true
    @State private var showSheet: Bool = false
    @State private var qrCodeShowSheet = false
    private let autoAdvanceInterval: TimeInterval = 3.0
    @State private var showEditButton: Bool = false
    @State private var draggingItem: BackgroundImageUrl?
    @StateObject var bgImageUrl : BackgroundImageManager = BackgroundImageManager()
    
    @State private var imageList = [
        BackgroundImageUrl(bgUrl: "wallet", title: "Account"),
        BackgroundImageUrl(bgUrl: "bill", title: "Pay Bills"),
        BackgroundImageUrl(bgUrl: "transericon", title: "Transfer"),
        BackgroundImageUrl(bgUrl: "favorite", title: "Favorite"),
        BackgroundImageUrl(bgUrl: "scan-fill", title: "ABA Scan"),
        BackgroundImageUrl(bgUrl: "service", title: "Service"),
    ]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            VStack{
                HeaderView(qrCodeShowSheet: $qrCodeShowSheet)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading){
                        
                        VStack(spacing: 25){
                            BalanceCardView(blurValue: $blurValue)
                            VStack{
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(imageList) { item in
                                        DragDropView(image: item.bgUrl, text: item.title)
                                            .onDrag {
                                                draggingItem = item
                                                return NSItemProvider(object: item.title as NSString)
                                            }
                                            .onDrop(of: [.text],
                                                    delegate: DropViewDelegate(
                                                        currentItem: item,
                                                        items: $imageList,
                                                        draggingItem: $draggingItem
                                                    )
                                            )
                                    }
                                    
                                }
                                .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: 250, alignment: .leading)
                            .background(.white.opacity(0.6))
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 15)
                        
                        
                        customTextView(text: "News and Information")
                        
                        VStack{
                            SliderSecticonView(selectedTab: $selectedTab)
                        }
                        .padding(.horizontal, 15)
                        
                        customTextView(text: "Favorites")
                        
                        customScrollView(items: staffList) { staff in
                            VStack(spacing: 10) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 60, height: 60)
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                    .overlay {
                                        Text(staff.status)
                                            .font(.system(size: 20))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                Text(staff.name)
                                    .font(.system(size: 16))
                            }
                            .padding()
                            .frame(width: 150, height: 160, alignment: .topLeading)
                            .background(.white)
                            .cornerRadius(20)
                        }
                        
                        
                        HStack{
                            customTextView(text: "Explore Services")
                            Spacer()
                            customTextView(text: "VIEW ALL")
                        }
                        
                        
                        customScrollView(items: serviceList){ item in
                            VStack(alignment: .leading){
                                Image(item.bgUrl)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(20)
                                    .padding(4)
                                    .background(.white)
                                    .cornerRadius(20)
                                Group{
                                    Text(item.title)
                                    Text("Services")
                                }
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            }
                        }
                        
                        HStack{
                            customTextView(text: "Goverment Services")
                            Spacer()
                            customTextView(text: "VIEW ALL")
                        }
                        
                        
                        customScrollView(items: govermentServiceList){ item in
                            VStack(alignment: .leading){
                                
                                Image(item.bgUrl)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(20)
                                    .padding(4)
                                    .background(.white)
                                    .cornerRadius(20)
                                Group{
                                    Text("Metfone")
                                    Text("Services")
                                }
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            }
                        }
                        
                        HStack(alignment: .center){
                            Button(action: {
                                showSheet.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "highlighter")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(Color(.systemGray3))
                                    Text("Edit Home")
                                        .foregroundStyle(Color(.systemGray3))
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(.white)
                                .cornerRadius(30)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                }
                
                .padding(.vertical)
                .sheet(isPresented: $showSheet){
                    VStack{
                        SheetView(bgChanger: bgImageUrl)
                    }
                    .padding()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
                    .background(Color(.systemGray5))
                }
                .fullScreenCover(isPresented: $qrCodeShowSheet){
                    QRCodeGenerater(isPresented: $qrCodeShowSheet)
                }
            }
            .onLongPressGesture {
                withAnimation {
                    showSheet = true
                }
            }
        }
        .background(
            Image(bgImageUrl.backgroundImageUrl)
        )
        .padding(.horizontal,10)
        
    }
    
}
#Preview {
    ContentView()
}
