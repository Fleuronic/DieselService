// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import protocol Catena.Model
import struct Diesel.Address
import struct Diesel.Location
import struct Foundation.UUID
import protocol Identity.Identifiable

public struct IdentifiedAddress {
	public let id: Self.ID
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
public extension Address.Identified {
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

// MARK: -
extension Address.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Address.Identified: Catena.Model {
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
		[
			\.location.id: \.location
		]
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
