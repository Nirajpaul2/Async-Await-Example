//
//  ApiManager.swift
//  APICallExample
//
//  Created by Purplle on 01/03/22.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private init() {
    }
    
    func getPosts(completion: @escaping (String) -> Void) {
       let url = URL(string:"https://jsonplaceholder.typicode.com/posts")!
       URLSession.shared.dataTask(with: url) { data, response, error in
       guard let data = data else { return }
       let string = String(data: data, encoding: .utf8) ?? ""
          completion(string)
       }.resume()
    }
   
    func getPostDetails( userId: Int, completion: @escaping (String) -> Void) {
       let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)")!
       URLSession.shared.dataTask(with: url) { data, response, error in
       guard let data = data else { return }
       let string = String(data: data, encoding: .utf8) ?? ""
          completion(string)
       }.resume()
    }
    
    func getAlbums(completion: @escaping (String) -> Void) {
       let url = URL(string:"https://jsonplaceholder.typicode.com/albums")!
       URLSession.shared.dataTask(with: url) { data, response, error in
       guard let data = data else { return }
       let string = String(data: data, encoding: .utf8) ?? ""
          completion(string)
       }.resume()
    }
    
    
    //Mark: Use Async/Await
    func getPosts() async throws -> String {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data,_) = try await URLSession.shared.data(from: url)
        let string = String(data: data, encoding: .utf8) ?? ""
        return string
    }
    
    func getUsers() async throws -> String {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let (data,_) = try await URLSession.shared.data(from: url)
        let string = String(data: data, encoding: .utf8) ?? ""
        return string
    }
    
    func getAlbums() async throws -> String {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let (data,_) = try await URLSession.shared.data(from: url)
        let string = String(data: data, encoding: .utf8) ?? ""
        return string
    }
    
    //Mark: Multiple network requests in parallel
    func getItems() async throws -> [String] {
    do {
        let url1 = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        async let (data1,_) = try URLSession.shared.data(from: url1)
        let url2 = URL(string: "https://jsonplaceholder.typicode.com/users")!
        async let (data2,_) = try URLSession.shared.data(from: url2)
        let url3 = URL(string:    "https://jsonplaceholder.typicode.com/albums")!
        async let (data3,_) = try URLSession.shared.data(from: url3)
        let data = try await [data1, data2, data3]
        let strings = data.compactMap({ String(data: $0, encoding: .utf8)})
        return strings
        } catch let error {
             throw(error)
          }
    }
    
}
