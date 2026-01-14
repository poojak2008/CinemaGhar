//
//  DataPresistenceManager.swift
//  CinemaGhar
//
//  Created by pooja kamble on 09/01/26.
//

import Foundation
import UIKit
import CoreData

class DataPresistenceManager {
    
    
    enum DataBaseError: Error {
        case failedToSave
    }
    static let shared = DataPresistenceManager()
    
    func favoritesTitleWith(model: Titles, completion: @escaping (Result<Void , Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = Favorites(context: context)
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSave))
        }
    }
    
    
    func fetchFavorites(completion: @escaping (Result<[Favorites], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Favorites>
        request = Favorites.fetchRequest()

        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteFavorite(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let results = try context.fetch(request)

            for object in results {
                context.delete(object)
            }

            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }


    func isFavorite(id: Int, completion: @escaping (Bool) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(false)
            return
        }

        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let count = try context.count(for: request)
            completion(count > 0)
        } catch {
            completion(false)
        }
    }

}

