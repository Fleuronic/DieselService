// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Show
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol ShowFields: Fields where Model == Show.Identified {}
