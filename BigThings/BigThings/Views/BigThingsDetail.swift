//
//  BigThingsDetail.swift
//  BigThings
//
//  Created by Yifeng on 28/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import MapKit


//This Class displays the details of each big thing
struct BigThingsDetail: View {
    
    var post: BigThing
    @EnvironmentObject var favouriteData: FavouriteData
    @State var selected = -1
    @State var showingAlert = false
    
    //Gets the index of the big thing
    var postIndex: Int {
        favouriteData.loaded.firstIndex(where: { $0.id == post.id })!
    }
    var body: some View {

        List{
            VStack {
               //Displays the location in a map view
               MapView(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(post.latitude)!), longitude: CLLocationDegrees(Double(post.longitude)!))).frame(height: 300)
               //Displays the image
               Image(uiImage:post.image)
                    .resizable()
                    .frame(width:200, height:200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .offset(x: 0, y: -130)
                    .padding(.bottom, -130)
                
                VStack {
                    HStack{
                        //Displays the name of big thing
                        Text(post.name)
                            .font(.title)
                        //A button that enables the user to add the big thing to favourite
                         Button(action: {
                            self.favouriteData.loaded[self.postIndex]
                               .isFavorite.toggle()
                         }) {
                            if self.favouriteData.loaded[self.postIndex]
                               .isFavorite {
                                //Displays a full heart if added to favourite
                               Image(systemName: "heart.fill")
                                   .foregroundColor(Color.red)
                           } else {
                               Image(systemName: "heart")
                                   .foregroundColor(Color.red)
                              }
                            }
                    }
                    //Displays the location
                    Text(post.location)
                        .font(.subheadline).foregroundColor(.blue)
                    //Displays the average rating
                    Text("Average Rating: " + post.rating).foregroundColor(.red)
                    if(self.selected != -1){
                        
                    }
                    //Allows the user to rate for the big thing
                    HStack{
                        Text("Upload Your Rating")
                        ForEach(0..<5){ i in
                            Image(systemName: "star.fill").foregroundColor(self.selected >= i ? .yellow : .gray).onTapGesture {
                                self.selected = i
                                self.uploadRating(id: self.post.id,rating: String(i))
                                self.showingAlert.toggle()
                            }.alert(isPresented: self.$showingAlert){
                                Alert(title: Text("Your rating has been successfully submitted to online server"))
                            }
                        }
                    }

                    Spacer()
                    
                    //Displays the description of the big thing
                    Text(post.description)
                        .font(.subheadline)
                    //}
                }
                .padding()
                
                Spacer()
            } .navigationBarTitle(Text(verbatim: post.name), displayMode: .inline)
        }

    }
    //upload rating
       func uploadRating(id:String,rating:String)
       {
           let url = NSURL(string: "http://www.partiklezoo.com/bigthings/?action=rate&id="+id+"&rating="+rating)
           let config = URLSessionConfiguration.default
           let session = URLSession(configuration: config)
           
           let task = session.dataTask(with: url! as URL, completionHandler:
           {(data, response, error) in
               if (error != nil) { return; }
               if let json = try? JSON(data: data!) {
                   if json.count > 0 {
                       for count in 0...json.count - 1 {
                           let jsonData = json[count]
                           print(jsonData)
                       }
                   }
               }
           })
           
           task.resume()
       }
}

struct BigThingsDetail_Previews: PreviewProvider {
    static var previews: some View {
        //BigThingsRow(post: PostListViewModel().webService.loaded[0])
        let favouriteData = FavouriteData()
        return BigThingsDetail(post: favouriteData.loaded[0])
            .environmentObject(favouriteData)
    }
}

