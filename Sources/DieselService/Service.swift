// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import protocol Catenary.API
import protocol Catenoid.Database

public struct Service<API: Catenary.API, Database: Catenoid.Database> where Database.Store == Store<ReadWrite> {
	let api: API
	let database: Database

	public init(
		api: API,
		database: Database
	) {
		self.api = api
		self.database = database
	}
}

// MARK: -
public extension Service {
    typealias APIResult<Resource> = API.Result<Resource>
	typealias DatabaseResult<Resource> = Database.Result<Resource>
}
