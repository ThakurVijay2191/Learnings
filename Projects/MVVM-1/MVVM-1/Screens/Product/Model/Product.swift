//
//  Product.swift
//  MVVM-1
//
//  Created by Nap Works on 29/06/23.
//

import Foundation

struct Product{
    var id : Int
    var title : String
    var price : Double
    var description : String
    var category : String
    var image : String
    var rating : RatingModel
}

struct RatingModel{
    var rate : Double
    var count : Int
}
