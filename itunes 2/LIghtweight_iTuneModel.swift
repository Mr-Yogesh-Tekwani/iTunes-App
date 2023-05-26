//
//  LIghtweight_iTuneModel.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import Foundation


struct ResultsModel: Codable {
    var results: [ResultsData]
}
struct ResultsData: Codable {
    var trackId: Int?
    var artistName: String?
    var artworkUrl30: String?
    var trackName: String?
    var previewUrl: String?
    var kind: String?
}

