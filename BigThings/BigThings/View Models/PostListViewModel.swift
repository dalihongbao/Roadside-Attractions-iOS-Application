//
//  PostListViewModel.swift
//  BigThings
//
//  Created by Yifeng on 26/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//


import Foundation
import Combine
import SwiftUI
import CoreData

//This is the controller of the data
final class PostListViewModel: ObservableObject {
    //Overrides the observableobject function
    let objectWillChange = PassthroughSubject<PostListViewModel,Never>()
    //Get the data from api
    let webService = SingletonManager.webService
    
    init(){
        //Fetch posts from api
        
        fetchPosts()
        //Store into CoreData
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
        //self.store()
        //})
        //Load from CoreData

        self.load()
    }
    
    var posts = [CodableBigThing](){
        didSet{
            objectWillChange.send(self)
        }
    }
    
    private func fetchPosts(){
        webService.getAllPosts {
            self.posts = $0
        }
        
    }
    
    private func store(){
        webService.store()
    }
    
    private func load(){
        webService.loadData()
    }
    

    
    
    

}
