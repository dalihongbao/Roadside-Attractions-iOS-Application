//
//  DataManager.swift
//  BigThings
//
//  Created by Yifeng on 26/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//
import UIKit
import CoreData
import Foundation

class DataManager{
    var segueArray = [String]()
    var segueDictionary = Dictionary<String, UIImage>()
    
    var bigThings = [Post]()
    var storedBigThings = [NSManagedObject]()
    
    init() {
        segueArray.append("Home")
        segueArray.append("Recipes")
        
        segueArray.append("Favourites")
        
        segueDictionary["Home"] = UIImage(named: "home")
        segueDictionary["Recipes"] = UIImage(named: "menu")
        segueDictionary["Favourites"] = UIImage(named: "menu")
        
        self.refreshRecipes()
    }
    
   func refreshRecipes()
      {
          let url = NSURL(string: "https://www.partiklezoo.com/recipes/recipes.txt")
          let config = URLSessionConfiguration.default
          let session = URLSession(configuration: config)
          
          let task = session.dataTask(with: url! as URL, completionHandler:
          {(data, response, error) in
              if (error != nil) { return; }
              if let json = try? JSON(data: data!) {
                  if json.count > 0 {
                      for count in 0...json.count - 1 {
                          let jsonBigThings = json[count]
                          let newBigThings = BigThings(uid: jsonRecipe["uid"].string!, name: jsonBigThings["name"].string!, details: jsonBigThings["recipe"].string!)
                          let imageURLString = "https://www.partiklezoo.com/recipes/" + jsonRecipe["image"].string!
                          self.addItemToRecipes(newRecipe, imageURL: imageURLString)
                      }
                  }
              }
          })
          
          task.resume()
      }

    
}
