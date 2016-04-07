//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var hairetu:[String]? = ["きんとん","もも","かぼちゃ","くり","もも","きんとん","もも"]
var kennsaku = hairetu!.indexOf("もも")
print(kennsaku!)
let equalindex = hairetu!.filter { $0 == "もも" }//ちがう


var A = {
    (a:String) -> Bool in a == "きんとん"
}
var kinsaku = hairetu!.filter(A)
print(kinsaku)



// ここはArray+Ext.swift ってファイルに定義しましょう
extension Array {
    mutating func indexOfAll<T : Equatable>(obj : T) -> [Int] {
        var indexarray:[Int]=[]
        for (index, objeToCompare) in self.enumerate() {
            guard obj == objeToCompare as! T else { continue }
            indexarray.append(index)
        }
        return indexarray
    }
}
print(hairetu!.indexOfAll("きんとん"))//でけました！

var test = [1:"きなこ",3:"くり",2:"きんとん"]
var val = test.values
print(val)
