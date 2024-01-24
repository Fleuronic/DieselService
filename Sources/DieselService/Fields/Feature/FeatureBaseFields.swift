// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Feature
import struct Diesel.Corps
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct FeatureBaseFields {
	public let id: Feature.ID
	public let name: String
	public let corps: IDFields<Corps.Identified>?
}

extension FeatureBaseFields: FeatureFields {
	// MARK: ModelProjection
	public static let projection = Projection<Feature.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.corps.id
	)
}

// MARK: -
private extension FeatureBaseFields {
	init(
		id: Feature.ID,
		name: String,
		corpsID: Corps.ID?
	) {
		self.id = id
		self.name = name

		corps = corpsID.map { .init(id: $0) }
	}
}
