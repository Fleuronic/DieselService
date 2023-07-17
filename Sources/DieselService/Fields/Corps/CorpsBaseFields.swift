// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Corps
import struct Diesel.Location
import protocol Identity.Identifiable

public struct CorpsBaseFields {
	public let id: Corps.ID
	public let name: String
	public let locationID: Location.ID
}

// MARK: -
extension CorpsBaseFields: CorpsFields {
	// MARK: ModelProjection
	public static let projection = Projection<Corps.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.location.id
	)
}

// MARK: -
extension CorpsBaseFields: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Corps.Identified.CodingKeys.self)
		id = try container.decode(Corps.ID.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)

		let locationContainer = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .location)
		locationID = try locationContainer.decode(Location.ID.self, forKey: .id)
	}
}
