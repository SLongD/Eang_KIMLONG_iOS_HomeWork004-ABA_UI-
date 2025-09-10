//
//  DropView.swift
//  ABA_Clone
//
//  Created by Eang Kimlong on 9/9/25.
//
import SwiftUI
struct DropViewDelegate: DropDelegate {
    let currentItem: BackgroundImageUrl
    @Binding var items: [BackgroundImageUrl]
    @Binding var draggingItem: BackgroundImageUrl?
    
    

    func dropEntered(info: DropInfo) {
            guard let draggedItem = draggingItem,
                  draggedItem != currentItem,
                  let fromIndex = items.firstIndex(of: draggedItem),
                  let toIndex = items.firstIndex(of: currentItem)
            else { return }
            
            
            withAnimation(.easeInOut) {
                items.move(fromOffsets: IndexSet(integer: fromIndex),
                           toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
            }
        }
        
    func performDrop(info: DropInfo) -> Bool {
        draggingItem = nil
        return true
    }
}


struct DragDropView: View {
    let image: String
    let text: String
    var body: some View {
        HStack{
            VStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text(text)
                    .font(.system(size: 16))
            }
            .frame(width: 100, height: 100)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 2)
        }
    }
}
