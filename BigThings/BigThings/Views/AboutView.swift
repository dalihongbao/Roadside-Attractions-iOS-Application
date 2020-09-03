//
//  AboutView.swift
//  BigThings
//
//  Created by Yifeng on 28/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
//This Class Displays the about view of the App

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About Big Things").font(.headline)
            Image("BigThings").resizable().scaledToFit()
            Text("\n\n" + "The big things of Australia are a loosely related set of large structures, some of which are novelty architecture and some are sculptures. There are estimated to be over 150 such objects around the country. There are big things in every state and territory in continental Australia. Most big things began as tourist traps found along major roads between destinations. The big things have become something of a cult phenomenon, and are sometimes used as an excuse for a road trip, where many or all big things are visited and used as a backdrop to a group photograph. Many of the big things are considered works of folk art and have been heritage-listed, though others have come under threat of demolition.").font(.subheadline)
             Spacer()
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
