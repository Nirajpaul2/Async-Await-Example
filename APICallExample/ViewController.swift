//
//  ViewController.swift
//  APICallExample
//
//  Created by Purplle on 01/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init(priority: .background) {
            await useAsyncWaitMultipleApiCall()
        }
        
        

    }
    
    //MARk: Normal API call using closure
    func normalAPICallWithClosure() {
        APIManager.shared.getPosts { str in
            print(str)
        }
    }
    
    //MARk: Use async / await for API call
    func useAsyncAwaitApiCall() async {
        do {
            let postString = try await APIManager.shared.getPosts()
            print(postString)
        } catch let error {
            print(error)
        }
    }
    

    //MARK: Nested Clouse to use multiple API call
    func nestedClosure() {
        APIManager.shared.getPosts { posts in
            APIManager.shared.getPostDetails(userId: 1) { users in
                APIManager.shared.getAlbums { albums in
                    print(posts, users, albums)
                }
            }
        }
    }
    
    //MARK: async/await for multiple API call
    func useAsyncWaitMultipleApiCall() async {
        do {
            let posts = try await APIManager.shared.getPosts()
            let users = try await APIManager.shared.getUsers()
            let albums = try await APIManager.shared.getAlbums()
            print("Posts Data: \(posts)  users Data: \(users) albums: \(albums)")
        } catch let error {
            print(error)
        }
    }
    
    //MARK: use async/await for multiple API call parallely
    func parallelAPIcallUsebyAsyncAwait() async {
        do {
            let items: [String] = try await APIManager.shared.getItems()
            print(items)
        } catch let error {
            print(error)
        }
    }
}

