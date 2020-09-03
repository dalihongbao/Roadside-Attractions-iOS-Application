//
//  BigThingsRow.swift
//  BigThings
//
//  Created by Yifeng on 27/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI

//This class builds the row of the big things list
struct BigThingsRow: View {
    var post : BigThing//A big thing
    var body: some View {
        HStack {
            //The image of the big thing
            Image(uiImage:post.image)
                .resizable()
                .frame(width: 50, height: 50)
            //name of the big thing
            Text(verbatim: post.name)
            Spacer()
            
            //Display an heart icon if this item is marked as favourite
            if post.isFavorite{
                Image(systemName: "heart.fill")
                .imageScale(.medium)
                .foregroundColor(.red)
            }
        }
    }
}

struct BigThingsRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BigThingsRow(post: PostListViewModel().webService.loaded[0])
            BigThingsRow(post: PostListViewModel().webService.loaded[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
