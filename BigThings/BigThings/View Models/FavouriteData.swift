//
//  FavouriteData.swift
//  BigThings
//
//  Created by Yifeng on 30/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import Combine

//This class stores the favourite big things marked by the user
final class FavouriteData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var loaded = PostListViewModel().webService.loaded
}
