// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenary.IDCodingKeys
import struct Diesel.Address
import struct Diesel.Location
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct AddressBaseFields {
	public let id: Address.ID
	public let streetAddress: String
	public let zipCode: String
	public let locationID: Location.ID
}

// MARK: -
extension AddressBaseFields: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Model.CodingKeys.self)
		id = try container.decode(Address.ID.self, forKey: .id)
		streetAddress = try container.decode(String.self, forKey: .streetAddress)
		zipCode = try container.decode(String.self, forKey: .zipCode)
		
		let locationContainer = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .location)
		locationID = try locationContainer.decode(Location.ID.self, forKey: .id)
	}
}

extension AddressBaseFields: AddressFields {
	// MARK: ModelProjection
	public static let projection = Projection<Address.Identified, Self>(
		Self.init,
		\.id,
		\.value.streetAddress,
		\.value.zipCode,
		\.location.id
	)
}
