//
//  NetworkManager.swift
//  getImageFromServer
//
//  Created by Artur on 08.11.2022.
//

import UIKit

class NetrworkManager{
    static func getRequest(url:String) {
        
        guard let url = URL(string: url) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response,
                let data = data
            else {return}
            print (response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                
            } catch {
                print("Error")
                
            }
        } .resume()
    }
    static func postRequest(url: String) {
        guard let url = URL(string: url) else {return}
        
        let userData = ["Course" : "Networking", "Lesson" : "Get and POST"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response else {return}
            
            print(data)
            print(response)
            
            do{
                let json = try JSONSerialization.jsonObject(with: data)
                print (json)
            } catch {
                print("error")
            }
        } .resume()
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()){
        //    https://picsum.photos/300/400
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image  = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        } .resume()
    }
    
    static func fetchData(url: String,completion: @escaping (_ courses:[Course])->()){
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            
            do{
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                completion(courses)
            } catch let error {
                print("Error selialization json", error)
                
            }
            
            
        } .resume()
    }
    static func uploadImage(url: String) {
        let image = UIImage(named: "sun")!
        let httpHeaders = ["Authorization": "Client-ID f6db5c9d7471ddd"]
        
        guard let imageProperties = ImageProperties(wothImage: image, forKey: "image") else {return}
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                    
                }catch{
                    print("Error")
                }
            }
        } .resume()
    }
}
