//
//  Music.swift
//  mykara
//
//  Created by Yo_4040 on 2025/04/07.
//

import Foundation
import SwiftData

@Model
final class Music {
    // 基本情報
    var title: String
    var artist: String
    var genre: String
    var releaseYear: Int?
    // カラオケ用
    var highScore: Int?
    var karaokeType: KaraokeType?    // dam or joysound?
    var key: Int
    var vocalRange: String  // 音域
    var dateSung: Date // 歌った日付？
    var comments: String
    var star: Int // 自分にとってどれくらいお気に入りか
    var lyrics: String
    var count: Int
    
    init(title: String, artist: String, genre: String, releaseYear: Int? = nil, highScore: Int? = nil, dateSung: Date, key: Int, comments: String, star: Int, vocalRange: String, karaokeType: KaraokeType? = nil, lyrics: String, count: Int) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.releaseYear = releaseYear
        self.highScore = highScore
        self.dateSung = dateSung
        self.key = key
        self.comments = comments
        self.star = star
        self.vocalRange = vocalRange
        self.karaokeType = karaokeType
        self.lyrics = lyrics
        self.count = count
    }
}
