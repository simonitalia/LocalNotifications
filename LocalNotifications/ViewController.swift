//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Simon Italia on 2/8/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
//    @objc func registerLocal() {
//
//    }
//
//    @objc func scheduleLocal() {
//
//    }
    
    @IBAction func registerLocalAlertsButton(_ sender: Any) {
        
        //Create notificationCenter object
        let notificationCenter = UNUserNotificationCenter.current()
        
        //Set properties
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            if granted {
                print("Permission granted")
                    
            } else {
                print("Permission denied!")
            }
        }
    }
    
    @IBAction func scheduleLocalAlertsButton(_ sender: Any) {
        
        registerCategories()
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        //Configure notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Late wake up call"
        notificationContent.body = "The early bird catches the worm, but the second mouse gets the cheese"
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["customData": "fizzbuzz"]
        notificationContent.sound = UNNotificationSound.default
        
        //Interval based trigger
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        ////Configure request with calendar based trigger
        let timeIntervalNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: timeIntervalTrigger)
        
        notificationCenter.add(timeIntervalNotificationRequest)
        
        //Calendar based trigger
        //Configure notification Date Component property for when to trigger notification
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//
//        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        //Configure request with calendar based trigger
//        let calendarNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: calendarTrigger)
//
//        notificationCenter.add(calendarNotificationRequest)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func registerCategories() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        let showNotificationAction = UNNotificationAction(identifier: "showAction", title: "Tell me more...", options: .foreground)
        
        let notificationCategory = UNNotificationCategory(identifier: "alarm", actions:[showNotificationAction], intentIdentifiers: [])
        
        notificationCenter.setNotificationCategories([notificationCategory])
 
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            //pull out the buried userInfo dictionary
        
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                
                print("Default identifier")
                
            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")
                
            default:
                break
            }
        }
        
        // you must call the completion handler when you're done
        completionHandler()
        
    }
    
}
