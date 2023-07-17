// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Address
import protocol Catena.Fields

protocol AddressFields: Fields where Model == Address.Identified {}
