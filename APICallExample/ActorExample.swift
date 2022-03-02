//
//  ActorExample.swift
//  APICallExample
//
//  Created by Purplle on 01/03/22.
//

import Foundation
import UIKit

class ActorClass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        test2()
        
    }
    

    //Unexpected behaviour
    func test1() {
        let bookStore: BookStore = BookStore()
        
        let queue1: DispatchQueue = DispatchQueue(label: "queue1")

        let queue2: DispatchQueue = DispatchQueue(label: "queue2")

        queue1.async {
            bookStore.purchase(book: "Book3")
        }
        
        queue2.async {
            bookStore.availableBook()
        }
    }
    
    //Solve issue by barrier
    func test2() {
        let bookStore: BookStoreExampleByDispatchBarrier = BookStoreExampleByDispatchBarrier()
        
        let queue1: DispatchQueue = DispatchQueue(label: "queue1")

        let queue2: DispatchQueue = DispatchQueue(label: "queue2")

        queue1.async {
            bookStore.purchase(book: "Book3")
        }
        
        queue2.async {
            bookStore.availableBook()
        }
    }
}

class BookStore {
    var booksInstock :[String] = ["Book1", "Book2", "Book3" ]
    func availableBook() {
            print("available book for purchase are = \(booksInstock)")
    }
    func purchase(book: String) {
        guard let index = self.booksInstock.firstIndex(of: book) else {
            print("no such book in stock")
            return
        }
            self.booksInstock.remove(at: index)
            print("Congratulations on purchase of a new \(book) 🎉 ")
    }
}

//MARK: Here we are using dispatch barrier to solve this issue
//Use barrier here to allow only one thread at a time
//Manually we manage the concurrenly so its change to make it mistake

class BookStoreExampleByDispatchBarrier {
    var booksInstock :[String] = ["Book1", "Book2", "Book3" ]
    
    let barrierQueue : DispatchQueue = DispatchQueue(label: "barrierQueue", attributes: .concurrent)
    
    func availableBook() {
        barrierQueue.sync(flags: .barrier) {
            print("available book for purchase are = \(booksInstock)")
        }
           
    }
    func purchase(book: String) {
        barrierQueue.sync(flags: .barrier) {
            guard let index = self.booksInstock.firstIndex(of: book) else {
                print("no such book in stock")
                return
            }
                self.booksInstock.remove(at: index)
                print("Congratulations on purchase of a new \(book) 🎉 ")
        }
    }
}

//Mark: Actor
actor BookStoreExampleByActor {
    var booksInstock :[String] = ["Book1", "Book2", "Book3" ]
    
    func availableBook() {
            print("available book for purchase are = \(booksInstock)")
    }
    func purchase(book: String) {
            guard let index = self.booksInstock.firstIndex(of: book) else {
                print("no such book in stock")
                return
            }
                self.booksInstock.remove(at: index)
                print("Congratulations on purchase of a new \(book) 🎉 ")
    }
}
