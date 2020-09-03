//
//  SubmitBigThingsView.swift
//  BigThings
//
//  Created by Yifeng on 30/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

//This class is used to submit a new big thing
struct SubmitBigThingsView: View {
    @State var name: String = ""
    @State var username: String = ""
    @State var date = Date()
    @State var address: String = ""
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                //Input name of the big thing
                TextField("Name", text: $name)
                //Select date and time
                DatePicker(selection: $date){
                    Text("Date")
                }
                //Input username
                TextField("Username", text: $username)
                //Input address
                TextField("Address", text: $address)
                //Allow the user to select an image from gallery
                ZStack {
                   VStack {
                       Button(action: {
                           withAnimation {
                               self.showImagePicker.toggle()
                           }
                       }) {
                           Text("Show image picker")
                       }
                       image?.resizable().frame(width: 100, height: 100)
                   }
                   .sheet(isPresented: $showImagePicker) {
                       ImagePicker(image: self.$image)
                   }
               }
                //The Submit button
               Button(action: {
                    self.showingAlert.toggle()
               }) {
                HStack{
                    Spacer()
                    Text("Submit").foregroundColor(.red)
                    Spacer()
                }
               }.alert(isPresented: $showingAlert){
                //Show alert if any field is not completed
               if(name == "" || address == "" || username == ""){
                   return Alert(title: Text("Please complete all fields"))
               }
               else{
                   return Alert(title: Text("Submitted"))
               }
                   
               }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}



//Overrides the ImagePicker Controller
struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    @Binding var image: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?

        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}

//struct ContentView: View {
//
//    @State var showImagePicker: Bool = false
//    @State var image: Image? = nil
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Button(action: {
//                    withAnimation {
//                        self.showImagePicker.toggle()
//                    }
//                }) {
//                    Text("Show image picker")
//                }
//                image?.resizable().frame(width: 100, height: 100)
//            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: self.$image)
//            }
//        }
//    }
//}

struct SubmitBigThingsView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitBigThingsView()
    }
}
