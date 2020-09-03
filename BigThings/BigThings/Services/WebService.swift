//
//  WebService.swift
//  BigThings
//
//  Created by Yifeng on 26/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class WebService{
    
    var posts: [CodableBigThing] = []//A list holds the big things from api
    var loaded = [BigThing]()//A list holds the big things from CoreData
    var storedBigThings = [NSManagedObject]()//A list holds the big things from CoreData
//    init() {
//        self.getAllPosts()
//        self.store()
//        self.loadData()
//    }
    
    //Fetch th posts from the online api
    func getAllPosts(completion: @escaping ([CodableBigThing]) -> ()){
        guard  let url = URL(string:
            "https://partiklezoo.com/bigthings")
            else {
                fatalError("URL is not correct!")
        }
        
        //Decode the JSON file and store it into a list
        URLSession.shared.dataTask(with: url){ data, _, _ in

            self.posts = try!
                JSONDecoder().decode([CodableBigThing].self, from: data!)
            DispatchQueue.main.sync {
                completion(self.posts)
                self.store()
            }
        }.resume()
//    func getAllPosts(){
//        let url = NSURL(string: "https://partiklezoo.com/bigthings")
//               let config = URLSessionConfiguration.default
//               let session = URLSession(configuration: config)
//
//               let task = session.dataTask(with: url! as URL, completionHandler:
//               {(data, response, error) in
//                   if (error != nil) { return; }
//                   if let json = try? JSON(data: data!) {
//                       if json.count > 0 {
//                           for count in 0...json.count - 1 {
//                                let jsonBigThings = json[count]
//                                let newBigThings = CodableBigThing(id: jsonBigThings["id"].string!, name: jsonBigThings["name"].string!, location: jsonBigThings["location"].string!, year: jsonBigThings["year"].string!,  status: jsonBigThings["status"].string!, latitude: jsonBigThings["latitude"].string!,longitude: jsonBigThings["longitude"].string!,image: jsonBigThings["image"].string!, rating: jsonBigThings["rating"].string!,  votes: jsonBigThings["votes"].string!, updated: jsonBigThings["updated"].string!, description: jsonBigThings["description"].string!);
//                                self.posts.append(newBigThings)
//                           }
//                       }
//                   }
//               })
//
//               task.resume()
        
    }
    
    //Stores the data into CoreData
    func store(){
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Get the Core Data entry
        let entity = NSEntityDescription.entity(forEntityName: "BigThings", in: managedContext)
        for items in posts{
            if(storedBigThings.count < 9)
            {
                //Add items into the entity
                let thingsToAdd = NSManagedObject(entity: entity!, insertInto: managedContext)
                thingsToAdd.setValue(items.id, forKey: "id")
                thingsToAdd.setValue(items.name, forKey: "name")
                thingsToAdd.setValue(items.year, forKey: "year")
                thingsToAdd.setValue(items.status, forKey: "status")
                thingsToAdd.setValue(items.longitude, forKey: "longitude")
                thingsToAdd.setValue(items.latitude, forKey: "latitude")
                thingsToAdd.setValue(items.location, forKey: "location")
                thingsToAdd.setValue(items.votes, forKey: "votes")
                thingsToAdd.setValue(items.updated, forKey: "update")
                thingsToAdd.setValue(items.image, forKey: "image")
                thingsToAdd.setValue(items.description, forKey: "desc")
                thingsToAdd.setValue(items.rating, forKey: "rating")
                storedBigThings.append(thingsToAdd)
            }

            }
        print(storedBigThings.count)
             do {//Save
                 try managedContext.save()
                 print("saved")
             }
             catch let error as NSError
             {//Catch Error
                 print("Could not save. \(error), \(error.userInfo)")
             }
        
        }
    
    
    //Load data from CoreData
    func loadData()
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Fetch items from the big thing entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BigThings")
        
        do {
                let results = try managedContext.fetch(fetchRequest)
                //Gets the big things from CoreData
                storedBigThings = results as! [NSManagedObject]
                if (storedBigThings.count > 0)
                {
                    for index in 0 ... storedBigThings.count - 1
                    {
                        let id = storedBigThings[index].value(forKey: "id") as! String
                        let name = storedBigThings[index].value(forKey: "name") as! String
                        let location = storedBigThings[index].value(forKey: "location") as! String
                        let year = storedBigThings[index].value(forKey: "year") as! String
                        let status = storedBigThings[index].value(forKey: "status") as! String
                        let latitude = storedBigThings[index].value(forKey: "latitude") as! String
                        let longitude = storedBigThings[index].value(forKey: "longitude") as! String
                        let imageString = storedBigThings[index].value(forKey: "image") as! String
                        let rating = storedBigThings[index].value(forKey: "rating") as! String
                        let votes = storedBigThings[index].value(forKey: "votes") as! String
                        let updated = storedBigThings[index].value(forKey: "update") as! String
                        let description = storedBigThings[index].value(forKey: "desc") as! String
                        
                        let image = loadImage(imageString)
                        
                        //Create a big thing using the constructor
                        let loadedBigThings = BigThing(id: id, name: name, location: location, year: year,  status: status, latitude: latitude,
                        longitude: longitude,image: image, rating: rating,  votes: votes, updated: updated, description: description);
                        
                        //Append the big things into a list
                        loaded.append(loadedBigThings)
                    }
                }
            }
            catch let error as NSError
            {
                print("Could not load. \(error), \(error.userInfo)")
            }
    }
    
    //This function converts the image string to an UIImage
    func loadImage(_ imageURL: String) -> UIImage
       {
           var image: UIImage!
        if let url = NSURL(string: "https://www.partiklezoo.com/bigthings/images/" + imageURL)
           {
               if let data = NSData(contentsOf: url as URL)
               {
                   image = UIImage(data: data as Data)
               }
           }
           return image!
       }
       
}
