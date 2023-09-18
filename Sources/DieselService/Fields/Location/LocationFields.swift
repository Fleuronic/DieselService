// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Location
import protocol Schemata.ModelProjection

public protocol LocationFields: Fields where Model == Location.Identified {}
