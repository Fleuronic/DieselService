// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Location
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol LocationFields: Fields where Model == Location.Identified {}
