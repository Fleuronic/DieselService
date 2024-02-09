// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Address
import struct Diesel.Location
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedAddress {
	public let id: ID
	public let value: Address
	public let location: Location.Identified
}

// MARK: -
public extension Address {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedAddress

	func identified(
		id: ID? = nil,
		location: Location.Identified
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			location: location
		)
	}

	var matches: Predicate<Identified> {
		\.value.streetAddress == streetAddress && \.value.zipCode == zipCode
	}
}

// MARK: -
extension Address.Identified {
	init(
		fields: AddressBaseFields,
		location: Location.Identified
	) {
		self.init(
			id: fields.id,
			streetAddress: fields.streetAddress,
			zipCode: fields.zipCode,
			location: location
		)
	}
}

extension Address.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."addresses",
		\.id * "id",
		\.value.streetAddress * "street_address",
		\.value.zipCode * "zip_code",
		\.location --> "location"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.streetAddress == value.streetAddress,
			\.value.zipCode == value.zipCode,
			\.location.id == location.id
		]
	}

	public static var relationships: Relationships {
		[\.location.id: \.location]
	}
}

// MARK: -
private extension Address.Identified {
	init(
		id: ID,
		streetAddress: String,
		zipCode: String,
		location: Location.Identified
	) {
		self.id = id
		self.location = location
		
		value = .init(
			streetAddress: streetAddress,
			zipCode: zipCode
		)
	}
}
