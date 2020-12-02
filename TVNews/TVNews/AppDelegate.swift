//
//  AppDelegate.swift
//  TVNews
//
//  Created by Станислав Лемешаев on 02.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let categories = ["Бизнес", "Культура", "Спорт", "Технологии", "Путешествия"]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // берем корневой контроллер представления и безопасно выбираем его как контроллер панели вкладок
        if let tabBarController = window?.rootViewController as? UITabBarController {
            // создаем пустой view controller
            var viewControllers = [UIViewController]()
            // просматриваем все категории
            for category in categories {
                // создаем новый view controller этой категории
                if let newsController = tabBarController.storyboard?.instantiateViewController(identifier: "News") as? ViewController {
                    // даем имя этой категории
                    newsController.title = category
                    // добавляем к нашему массиву view controllers
                    viewControllers.append(newsController)
                }
            }
            tabBarController.viewControllers = viewControllers
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

