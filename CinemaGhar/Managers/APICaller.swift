//
//  APICaller.swift
//  CinemaGhar
//
//  Created by pooja kamble on 11/12/25.
//

import Foundation

struct Constant {
    static let API_Key = "6f491cae4b1d6af610dd62264b286dff"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError : Error {
    case failedToGetData
}


class APICaller {
    static let shared = APICaller()
    
    
    
    func getTrendingMovies(completion: @escaping (Result<[Titles],Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?language=en-US&api_key=\(Constant.API_Key)") else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,error == nil else {
                print("Invalid URL")
                return
            }
            
            do{
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    
    func getTrendingTV(completion: @escaping (Result<[Titles],Error>) -> Void)  {
        guard let url = URL(string:"\(Constant.baseURL)/3/trending/tv/day?language=en-US&api_key=\(Constant.API_Key)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,error == nil else{
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
                
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
            dataTask.resume()
    }
    
    func getUpComingMovies(completion: @escaping(Result<[Titles],Error>)-> Void){
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/upcoming?api_key=\(Constant.API_Key)") else{
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    func getPopular(completion: @escaping(Result<[Titles],Error>)-> Void){
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/popular?api_key=\(Constant.API_Key)") else{
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()

    }
    
    func getTopRated(completion: @escaping(Result<[Titles],Error>)-> Void){
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/top_rated?api_key=\(Constant.API_Key)") else{
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()

    }
}

 
