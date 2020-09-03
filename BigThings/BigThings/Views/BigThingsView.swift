//
//  ContentView.swift
//  BigThings
//
//  Created by Yifeng on 25/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import Foundation

struct BigThingsView: View {
    //An model that oberserves the changes of the big things data
    @ObservedObject var model = PostListViewModel()
    //An environment object that holds user's favourite big things
    @EnvironmentObject  private var favouriteData : FavouriteData
    //A state used to search big things
    @State private var searchTerm: String = ""
    var body: some View {

            List {
                //Search item based on user input
                SearchBar(text: $searchTerm)
                //Show favourite itmes only if toggle is on
                Toggle(isOn: $favouriteData.showFavoritesOnly) {
                    HStack{
                        Text("Favorites only")
                        Image(systemName: "heart.fill").foregroundColor(.red)
                    }
                }
                
                //Filters favourite big things and implements the search bar
                ForEach(favouriteData.loaded.filter{
                    self.searchTerm.isEmpty ? true :
                        "\($0)".contains(self.searchTerm)
                }) { post in
                    if !self.favouriteData.showFavoritesOnly || post.isFavorite {
                        //Loads all the big things
                    NavigationLink(destination: BigThingsDetail(post: post).environmentObject(self.favouriteData)) {
                            BigThingsRow(post: post)
                        }
                   }
                }
            }
        .navigationBarTitle(Text("Big Things"))
        .navigationViewStyle(StackNavigationViewStyle())// Set to stack navigation style to display the contents properly in landscape mode
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BigThingsView()
    }
}
