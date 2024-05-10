//
//  SimpleMusicPlayerTests.swift
//  SimpleMusicPlayerTests
//
//  Created by Admin on 14/11/2023.
//

import XCTest
@testable import SimpleMusicPlayer
/*
final class SimpleMusicPlayerTests: XCTestCase {
        
    func testRankArtistsByPlaysWithEmptyList() {
        let result = rankArtistsByPlays(artistList: [])
        XCTAssertTrue(result.isEmpty, "Result should be empty when input list is empty")
    }
    
    func testRankArtistsByPlaysWithFewerThanSixArtists() {
        let artists = [artistObj(name: "Artist1", plays: 100),
                       artistObj(name: "Artist2", plays: 200),
                       artistObj(name: "Artist3", plays: 300)]
        let result = rankArtistsByPlays(artistList: artists)
        XCTAssertEqual(result.count, artists.count, "Result should have the same number of artists as input")
    }
    
    func testRankArtistsByPlaysWithExactlySixArtists() {
        let artists = [artistObj(name: "Artist1", plays: 100),
                       artistObj(name: "Artist2", plays: 200),
                       artistObj(name: "Artist3", plays: 300),
                       artistObj(name: "Artist4", plays: 400),
                       artistObj(name: "Artist5", plays: 500),
                       artistObj(name: "Artist6", plays: 600)]
        let result = rankArtistsByPlays(artistList: artists)
        XCTAssertEqual(result.count, 6, "Result should have exactly six artists")
    }
    
    func testRankArtistsByPlaysWithMoreThanSixArtists() {
        let artists = [artistObj(name: "Artist1", plays: 100),
                       artistObj(name: "Artist2", plays: 200),
                       artistObj(name: "Artist3", plays: 300),
                       artistObj(name: "Artist4", plays: 400),
                       artistObj(name: "Artist5", plays: 500),
                       artistObj(name: "Artist6", plays: 600),
                       artistObj(name: "Artist7", plays: 700)]
        let result = rankArtistsByPlays(artistList: artists)
        XCTAssertEqual(result.count, 6, "Result should have exactly six artists")
        XCTAssertTrue(result.contains(where: { $0.name == "Others" }), "Result should contain 'Others' artist")
    }

}
*/
