// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import struct Diesel.Location
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedLocation {
	public let id: ID
	public let value: Location
}

// MARK: -
public extension Location {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedLocation

	func identified(id: ID? = nil) -> Identified {
		.init(
			id: id ?? .random,
			value: self
		)
	}

	var matches: Predicate<Identified> {
		\.value.city == city && \.value.state == state
	}
}

// MARK: -
public extension Location.Identified {
	init(fields: LocationBaseFields) {
		id = fields.id
		value = .init(
			city: fields.city,
			state: fields.state
		)
	}
}

// MARK: -
extension Location.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."locations",
		\.id * "id",
		\.value.city * "city",
		\.value.state * "state"
	)

	// MARK: Model
	public var valueSet: ValueSet<Self> {
		[
			\.value.city == value.city,
			\.value.state == value.state
		]
	}
}

// MARK: -
private extension Location.Identified {
	init(
		id: ID,
		city: String,
		state: String
	) {
		self.id = id
		
		value = .init(
			city: city,
			state: state
		)
	}
}

// MARK: -
public extension [Location] {
	var city: [String] { map(\.city) }
	var state: [String] { map(\.state) }
}

// MARK: -
public extension [Location.Identified] {
	var id: [Location.ID] { map(\.id) }
	var value: [Location] { map(\.value) }
}
