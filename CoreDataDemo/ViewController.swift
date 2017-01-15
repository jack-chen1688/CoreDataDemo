//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Xuehua Chen on 1/12/17.
//  Copyright © 2017 Xuehua Chen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("Bill", forKey: "username")
        newUser.setValue("myPass", forKey: "password")
        newUser.setValue(39, forKey: "age")
        
        do {
            try context.save()
            print("Saved successfully")
        } catch  {
            print("There was an error")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username")  as? String {
                        print("username is", username)
                    }
                }
            } else {
                print("no result")
            }
        } catch  {
            print ("fetch error");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

