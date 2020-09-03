//
//  HomeView.swift
//  BigThings
//
//  Created by Yifeng on 29/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

//This is the Home Menu of the APP
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            //Navigations to different views
            List{
                //Navigations to different views
                    NavigationLink(destination: BigThingsView()) {
                        Text("View Big Things")
                        Image(systemName: "eye").foregroundColor(.blue)
                    }
                    NavigationLink(destination: BigThingsNearByView()) {
                        Text("Big Things Nearby ")
                        Image(systemName: "map").foregroundColor(.blue)
                    }
                    NavigationLink(destination: SubmitBigThingsView()) {
                        HStack{
                            Text("Submit A Big Thing")
                            Image(systemName: "plus").foregroundColor(.blue)
                        }
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("About Big Things")
                    Image(systemName:"info.circle").foregroundColor(.blue)
                    }

            }.navigationBarTitle(Text("Home"))
        }.navigationViewStyle(StackNavigationViewStyle())
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
}
