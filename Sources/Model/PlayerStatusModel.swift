/*
 The MIT License (MIT)

 Copyright © 2021 Frank Gregor <phranck@woodbytes.me>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the “Software”), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation

public struct PlayerStatusModel: Codable {
    public var album: String
    public var artist: String
    public var title: String
    public var volume: Int
    public var status: PlayerStatus

    enum CodingKeys: String, CodingKey {
        case album  = "Album"
        case artist = "Artist"
        case title  = "Title"
        case volume = "vol"
        case status
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album  = try values.decode(String.self, forKey: .album)
        artist = try values.decode(String.self, forKey: .artist)
        title  = try values.decode(String.self, forKey: .title)

        let volumeString = try values.decode(String.self, forKey: .volume)
        volume = Int(volumeString)!

        status = try values.decode(PlayerStatus.self, forKey: .status)
    }
}

public enum PlayerStatus: String, Codable {
    case stop, play, load, pause
}

public enum PlayerType: Int, Codable {
    case main  = 0
    case child = 1
}

public enum PlayerMuteStatus: Int, Codable {
    case unmuted = 0
    case muted   = 1
}

public enum PlayerPlaybackMode: Int, Codable {
    case none          = 0
    case airplay       = 1
    case dlna          = 2
    case wiimu         = 10
    case wiimuLocal    = 11
    case wiimuStation  = 12
    case wiimuRadio    = 13
    case wiimuSonglist = 14
    case wiimuMax      = 19
    case http          = 20
    case httpLocal     = 21
    case httpMax       = 29
    case alarm         = 30
    case lineIn        = 40
    case bluetooth     = 41
    case extLocal      = 42
    case optical       = 43
    case lineInMax     = 49
    case mirror        = 50
    case talk          = 60
    case child         = 99
}

public enum PlayerLoopMode: Int, Codable {
    case sequential = 0       // sequential playback, no loop
    case single     = 1       // loop over one single track
    case shuffleAll = 2       // shuffle playback over all tracks (of a playlist)
    case loopAll    = 3       // sequential playback, go to start when finished
}

public enum PlayerChannelMode: Int, Codable {
    case stereo = 0
    case left   = 1
    case right  = 2
}
