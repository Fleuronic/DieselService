// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import protocol Catena.Fields

protocol CorpsFields: Fields where Model == Corps.Identified {}
