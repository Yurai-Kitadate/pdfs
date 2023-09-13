import Foundation

struct IntVariable :Variable{
    let lowerConstraint : Int64
    let upperConstraint : Int64
    func makeRandomCase() -> String{
        return String(Int64.random(in : lowerConstraint...upperConstraint)) + "\n"
    }
}

struct RowIntVariable :Variable{
    let rowSize : Int64
    let lowerConstraint : Int64
    let upperConstraint : Int64
    func makeRandomCase() -> String{
        var randomString = ""
        for i in 0..<rowSize{
            randomString += String(Int64.random(in : lowerConstraint...upperConstraint))
            if i == rowSize - 1{
                randomString += "\n"
            }else{
                randomString += " "
            }
        }
        return randomString
    }
}

struct ColumnIntVariable :Variable{
    let columnSize : Int64
    let lowerConstraint : Int64
    let upperConstraint : Int64
    func makeRandomCase() -> String{
        var randomString = ""
        for _ in 0..<columnSize{
            randomString += String(Int64.random(in : lowerConstraint...upperConstraint)) + "\n"
        }
        return randomString
    }
}

struct DoubleVariable :Variable{
    let lowerConstraint : Double
    let upperConstraint : Double
    func makeRandomCase() -> String{
        return String(Double.random(in: lowerConstraint...upperConstraint)) + "\n"
    }
}

struct StringVariable :Variable{
    let lengthLowerConstraint : Int64
    let lengthUpperConstraint : Int64
    let stringSet : String

    init(lengthLowerConstraint: Int64, lengthUpperConstraint: Int64, stringSet: String) {
        self.lengthLowerConstraint = lengthLowerConstraint
        self.lengthUpperConstraint = lengthUpperConstraint
        self.stringSet = stringSet == "abc!" ? "abcdefghijklmnopqrstuvwxyz" : stringSet

    }
    func makeRandomCase() -> String{
        let stringLength = Int64.random(in : lengthLowerConstraint...lengthUpperConstraint)
        var randomString = ""
        for _ in 0 ..< stringLength {
            randomString += String(stringSet.randomElement() ?? "a")
        }
        return String(randomString) + "\n"
    }
}

protocol Variable{
    func makeRandomCase() -> String
}
