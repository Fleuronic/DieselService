// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata
import PersistDB

import struct Diesel.Event
import struct Diesel.Venue
import struct Diesel.Corps
import struct Diesel.Location
import struct Diesel.Feature
import struct Foundation.UUID
import struct Foundation.TimeInterval
import protocol Catena.Model

public struct IdentifiedFeature {
	public let id: Self.ID

	let value: Feature
	let corps: Corps.Identified!
}

// MARK: -
public extension Feature {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedFeature

	func identified(
		id: ID? = nil,
		corps: Corps.Identified?
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			corps: corps
		)
	}

	func matches(with corps: Corps.Identified?) -> Predicate<Identified> {
		\.value.name == name &&
		(corps?.id).map { \.corps.id == $0 } ?? !\.corps
	}
}

// MARK: -
extension Feature.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Feature.Identified: Catena.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "features",
		\.id ~ "id",
		\.value.name ~ "name",
		\.corps ~? "corps"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.name == value.name,
            \.corps.id == corps?.id
		]
	}

	public static var foreignKeys: ForeignKeys {
		[
			\.corps.id: \.corps!
		]
	}
}

// MARK: -
private extension Feature.Identified {
	init(
		id: ID,
		name: String,
		corps: Corps.Identified?
	) {
		self.id = id
		self.corps = corps

		value = .init(
			name: name
		)
	}
}

// MARK: -
extension [Feature] {
	var name: [String] { map(\.name) }
}

// MARK: -
extension [Feature.Identified] {
	var id: [Feature.ID] { map(\.id) }
	var value: [Feature] { map(\.value) }
    var corps: [Corps.Identified] { map(\.corps) }
}
