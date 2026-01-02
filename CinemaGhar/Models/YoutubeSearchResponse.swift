//
//  YoutubeSearchResult.swift
//  CinemaGhar
//
//  Created by pooja kamble on 26/12/25.
//

import Foundation

struct YoutubeSearchResponse : Codable{
    
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IDVideoElement
}
struct IDVideoElement: Codable{
    let kind : String
    let videoId: String?
}
