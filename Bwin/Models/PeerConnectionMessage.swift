//
//  PeerConnectionMessage.swift
//  Bwin
//
//  Created by Tanya Koldunova on 19.10.2022.
//

import Foundation


enum PeerConnectionMessage: Codable {
    case connecting(ConnectingModel)
    case playing(PlayingModel)
    case gameOver
}

struct ConnectingModel: Codable {
    public let stake: Int
}

struct PlayingModel: Codable {
    public let score: Int
}

struct GameOver: Codable {
    public let finishScore: Int
}
