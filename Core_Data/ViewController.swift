//
//  ViewController.swift
//  Core_Data
//
//  Created by Mohsen Abdollahi on 4/18/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var usernameArray:[String] = []
    var passwordArray:[String] = []
    var emailArray:[String] = []
    
    
    
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDataBtn(_ sender: Any) {
        
        //First Step
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Sceond Step
        ////We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Third Step
        ////Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        
        let userNameText = userNameTextFiled.text
        let passwordText = passwordTextFiled.text
        let emailText = emailTextFiled.text

        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(userNameText, forKey: "username")
        user.setValue(passwordText, forKey: "password")
        user.setValue(emailText, forKey: "email")
        
        do {
            try managedContext.save()
            userNameTextFiled.text = ""
            passwordTextFiled.text = ""
            emailTextFiled.text = ""
            
//            Just For Sure Your Data Has been Saved !
//            print(userNameText!)
//            print(passwordText!)
//            print(emailText!)
            
        } catch {
            
            print("error  Could not Save !")
            
        }
  
    }
    
    
    @IBAction func showDataBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for myresult in results as! [NSManagedObject]
                {
                    if let username = myresult.value(forKey: "username") as? String
                    {
                    usernameArray.append(username)
                    }
                    
                    if let password = myresult.value(forKey: "password") as? String
                    {
                        passwordArray.append(password)
                    }
                    
                    if let email = myresult.value(forKey: "email")as? String
                    {
                        emailArray.append(email)
                    }

                }
                
                print(usernameArray)
                print(passwordArray)
                print(emailArray)
                
                
            }
         
            
        }
        catch
        {
            // PROCESS ERROR
        }
        
  
    }
    
}

