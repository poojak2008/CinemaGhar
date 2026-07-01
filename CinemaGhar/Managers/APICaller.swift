//
//  APICaller.swift
//  CinemaGhar
//
//  Created by pooja kamble on 11/12/25.
//

import Foundation

struct Constant {
    static let API_Key = "API key of themociedb"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "API Key of Youtube"
    static let YouTubebseURL = "https://youtube.googleapis.com/youtube/v3/search?"
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
            
            do   {
                
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
    
    
    func getDiscoverMovies(completion: @escaping(Result<[Titles],Error>)-> Void){
        guard let url = URL(string: "\(Constant.baseURL)/3/discover/movie?api_key=\(Constant.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
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
    
    
    func search(with query: String ,completion: @escaping(Result<[Titles],Error>)-> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return  }
        guard let url = URL(string: "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.API_Key)&query=\(query)") else {
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
    //q=harry&key=[YOUR_API_KEY]
    func getMoviesTrailer(with query: String ,completion: @escaping(Result<VideoElement,Error>)-> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return  }
        guard let url = URL(string: "\(Constant.YouTubebseURL)q=\(query)&key=\(Constant.YoutubeAPI_KEY)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
                print(result)
           
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
    
}
