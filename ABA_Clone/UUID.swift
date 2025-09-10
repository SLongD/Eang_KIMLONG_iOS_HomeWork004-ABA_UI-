//
//  UUID.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/8/25.
//


import Foundation

struct ImageUrl  {
    var url: String
}

//struct Image : Identifiable {
//    var id = UUID()
//}

struct BackgroundImageUrl : Identifiable, Equatable {
    var id = UUID()
    var bgUrl: String
    var title: String
}

struct Person : Identifiable {
    var id = UUID()
    var name: String
    var status: String
}

class BackgroundImageManager : ObservableObject, Identifiable {
    @Published var id : UUID? = nil
    @Published var backgroundImageUrl = "Sunset"
}
