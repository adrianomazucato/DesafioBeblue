//
//  Photo.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import Foundation

struct PhotoResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    var photos: [Photo]?
    
    public init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.photos = try baseContainer.decodeIfPresent([Photo].self, forKey: .photos)
    }

    public func encode(to encoder: Encoder) throws {
        
    }
}

struct Photo: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    let id: Double?
    let sol: Double?
    let camera: Camera?
    let imgSrc: String?
    let earthDate: Date?
    let rover: Rover?
    
    public init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try baseContainer.decodeIfPresent(Double.self, forKey: .id)
        self.sol = try baseContainer.decodeIfPresent(Double.self, forKey: .sol)
        self.camera = try baseContainer.decodeIfPresent(Camera.self, forKey: .camera)
        self.imgSrc = try baseContainer.decodeIfPresent(String.self, forKey: .imgSrc)
        self.earthDate = try baseContainer.decodeIfPresent(Date.self, forKey: .earthDate)
        self.rover = try baseContainer.decodeIfPresent(Rover.self, forKey: .rover)
    }
}

struct Camera: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
    
    let id: Double?
    let name: String?
    let roverID: Double?
    let fullName: String?

    public init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try baseContainer.decodeIfPresent(Double.self, forKey: .id)
        self.name = try baseContainer.decodeIfPresent(String.self, forKey: .name)
        self.roverID = try baseContainer.decodeIfPresent(Double.self, forKey: .roverID)
        self.fullName = try baseContainer.decodeIfPresent(String.self, forKey: .fullName)
    }
}

struct Rover: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
    
    let id: Int?
    let name: String?
    let landingDate: Date?
    let launchDate: Date?
    let maxSol: Double?
    let maxDate: Date?
    let totalPhotos: Double?
    let cameras: [Cameras]?
    
    public init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try baseContainer.decodeIfPresent(Int.self, forKey: .id)
        self.name = try baseContainer.decodeIfPresent(String.self, forKey: .name)
        self.landingDate = try baseContainer.decodeIfPresent(Date.self, forKey: .landingDate)
        self.launchDate = try baseContainer.decodeIfPresent(Date.self, forKey: .launchDate)
        self.maxSol = try baseContainer.decodeIfPresent(Double.self, forKey: .maxSol)
        self.maxDate = try baseContainer.decodeIfPresent(Date.self, forKey: .maxDate)
        self.totalPhotos = try baseContainer.decodeIfPresent(Double.self, forKey: .totalPhotos)
        self.cameras = try baseContainer.decodeIfPresent([Cameras].self, forKey: .cameras)
    }
}

struct Cameras: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
    
    let name: String?
    let fullName: String?
    
    public init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try baseContainer.decodeIfPresent(String.self, forKey: .name)
        self.fullName = try baseContainer.decodeIfPresent(String.self, forKey: .fullName)
    }
}
