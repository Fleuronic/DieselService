// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import protocol Catena.Model
import struct Diesel.Address
import struct Diesel.Venue
import struct Foundation.UUID
import protocol Identity.Identifiable

public struct IdentifiedVenue {
	public let id: Self.ID
	public let value: Venue
	public let address: Address.Identified
}

// MARK: -
public extension Venue {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedVenue

	func identified(
		id: ID? = nil,
		address: Address.Identified
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			address: address
		)
	}

	var matches: Predicate<Identified> {
		\.value.name == name
	}
}

// MARK: -
extension Venue.Identified {
	init(
		fields: VenueBaseFields,
		address: Address.Identified
	) {
		self.init(
			id: fields.id,
			name: fields.name,
			host: fields.host,
			address: address
		)
	}
}

// MARK: -
extension Venue.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Venue.Identified: Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."venues",
		\.id * "id",
		\.value.name * "name",
		\.value.host * "host",
		\.address --> "address"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.name == value.name,
			\.value.host == value.host,
			\.address.id == address.id
		]
	}

	public static var relationships: Relationships {
		[
			\.address.id: \.address
		]
	}
}

// MARK: -
private extension Venue.Identified {
	init(
		id: ID,
		name: String,
		host: String?,
		address: Address.Identified
	) {
		self.id = id
		self.address = address
		
		value = .init(
			name: name,
			host: host
		)
	}
}
