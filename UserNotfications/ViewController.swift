//
//  ViewController.swift
//  UserNotfications
//
//  Created by lokeshreddy on 1/23/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //request permission from the user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {(granted , error) in
            
            if granted {
             print("Notification access ")
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    
    
    @IBAction func sendnotificationpressed(_ sender: UIButton) {
        schedulenotification(inSeconds: 5, completion: {
            sucess in
            
            if sucess {
                print("sucessfully scheduled notification")
            }
            else{
                print("error")
            }
        })
       
    }
    
    
    func schedulenotification(inSeconds: TimeInterval, completion: @escaping (Bool) -> ()) {
        
        
        //add an attachment
        
     let myimage = "Green"
        guard let imageurl = Bundle.main.url(forResource: "Green", withExtension: "jpg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageurl, options: .none)
        
        
        
        //add content to notification
        let notification = UNMutableNotificationContent()
        notification.title = "New Notification"
        notification.subtitle = "These are great"
        notification.body = "The new notification options in ios are great!!!!!"
        
        notification.attachments = [attachment]
 
        let notificationtrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notification,trigger: notificationtrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            
            if error != nil {
                print(error)
                completion(false)
            }
            else {
                completion(true)
            }
            
            
        })
    
    
    
    
    }
    
}

