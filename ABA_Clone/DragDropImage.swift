import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct DragDropImagePicker: View {
    @State private var selectedImages: [UIImage] = []
    @State private var draggedOver = false
    @State private var isDocumentPickerShown = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Image Upload")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Drop zone with browse button
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(
                    draggedOver ? Color.blue : Color.gray.opacity(0.5),
                    style: StrokeStyle(lineWidth: 2, dash: [5])
                )
                .frame(height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(draggedOver ? Color.blue.opacity(0.1) : Color.gray.opacity(0.05))
                )
                .overlay(
                    VStack(spacing: 15) {
                        Image(systemName: draggedOver ? "icloud.and.arrow.down.fill" : "photo.badge.plus")
                            .font(.system(size: 40))
                            .foregroundColor(draggedOver ? .blue : .gray)
                        
                        Text(draggedOver ? "Drop images here" : "Drag & Drop images here")
                            .font(.headline)
                            .foregroundColor(draggedOver ? .blue : .gray)
                        
                        Text("or")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        Button(action: {
                            isDocumentPickerShown = true
                        }) {
                            HStack {
                                Image(systemName: "folder")
                                Text("Browse Files")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                )
                .onDrop(of: [UTType.image], isTargeted: $draggedOver) { providers in
                    handleDrop(providers: providers)
                }
            
            // Selected images display
            if !selectedImages.isEmpty {
                VStack(spacing: 15) {
                    HStack {
                        Text("Selected Images (\(selectedImages.count))")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button("Clear All") {
                            selectedImages.removeAll()
                        }
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                VStack {
                                    Image(uiImage: selectedImages[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(8)
                                        .shadow(radius: 2)
                                    
                                    Button(action: {
                                        selectedImages.remove(at: index)
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                    .padding(.top, 4)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 140)
                }
            }
        }
        .padding()
        .sheet(isPresented: $isDocumentPickerShown) {
            FolderBrowserPicker(selectedImages: $selectedImages)
        }
    }
    
    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let uiImage = image as? UIImage {
                        DispatchQueue.main.async {
                            selectedImages.append(uiImage)
                        }
                    }
                }
            }
        }
        return true
    }
}

struct FolderBrowserPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: [
                UTType.image,           // All images
                UTType.jpeg,            // JPEG
                UTType.png,             // PNG
                UTType.heif,            // HEIF
                UTType.gif,             // GIF
                UTType.tiff,            // TIFF
                UTType.webP             // WebP
            ],
            asCopy: true
        )
        
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = true
        picker.shouldShowFileExtensions = true
        
        // Customize the picker appearance
        picker.modalPresentationStyle = .formSheet
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: FolderBrowserPicker
        
        init(_ parent: FolderBrowserPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            var newImages: [UIImage] = []
            
            for url in urls {
                // Start accessing security-scoped resource
                _ = url.startAccessingSecurityScopedResource()
                
                defer {
                    // Stop accessing when done
                    url.stopAccessingSecurityScopedResource()
                }
                
                do {
                    let imageData = try Data(contentsOf: url)
                    if let uiImage = UIImage(data: imageData) {
                        newImages.append(uiImage)
                    }
                } catch {
                    print("Error loading image from \(url): \(error)")
                }
            }
            
            DispatchQueue.main.async {
                self.parent.selectedImages.append(contentsOf: newImages)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// Preview
//struct DragDropImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DragDropImagePicker()
//    }
//}
