// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Address
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol AddressFields: Fields where Model == Address.Identified {}
