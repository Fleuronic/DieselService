// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Corps
import struct Diesel.Location
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedCorps {
	public let id: Self.ID
	public let value: Corps
	public let location: Location.Identified
}

// MARK: -
public extension Corps {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedCorps

	var matches: Predicate<Identified> {
		\.value.name == name
	}

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

	func matches(with location: Location.Identified) -> Predicate<Identified> {
		\.value.name == name && \.location.id == location.id
	}
}

// MARK: -
public extension Corps.Identified {
	init(fields: CorpsNameLocationFields) {
		self.init(
			id: fields.id,
			name: fields.name,
			location: .init(fields: fields.location)
		)
	}
}

// MARK: -
extension Corps.Identified: Catena.Model {
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init ... "corps",
		\.id * "id",
		\.value.name * "name",
		\.location --> "location"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.name == value.name,
			\.location.id == location.id,
		]
	}

	public static var relationships: Relationships {
		[
			\.location.id: \.location,
		]
	}
}

// MARK: -
private extension Corps.Identified {
	init(
		id: ID,
		name: String,
		location: Location.Identified
	) {
		self.id = id
		self.location = location
		
		value = .init(name: name)
	}
}

// MARK: -
public extension [Corps] {
	var name: [String] { map(\.name) }
}

// MARK: -
public extension [Corps.Identified] {
	var id: [Corps.ID] { map(\.id) }
	var value: [Corps] { map(\.value) }
	var location: [Location.Identified] { map(\.location) }
}
