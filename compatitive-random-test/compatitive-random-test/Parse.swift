//
//  Parse.swift
//  random-test
//
//  Created by 北舘友頼 on 2023/04/11.
//

import Foundation

func parse(concatenatedString : String) -> String{
    
    var output = ""
    
    concatenatedString.enumerateLines{
        line,stop in
        let splitLine = line.components(separatedBy: " ")
        if splitLine == ["end"]{
            break
        }
        
        switch splitLine[0]{
        case "int":
            output += IntVariable(lowerConstraint: Int64(splitLine[1])!, upperConstraint: Int64(splitLine[2])!).makeRandomCase()
            
        case "str":
            output += StringVariable(lengthLowerConstraint: Int64(splitLine[1])!, lengthUpperConstraint:  Int64(splitLine[2])!, stringSet: splitLine[3]).makeRandomCase()
            
        case "dbl":
            output += DoubleVariable(lowerConstraint: Double(splitLine[1])!, upperConstraint: Double(splitLine[2])!).makeRandomCase()
            
            
        case "row":
            if splitLine[1] == "int"{
                output += RowIntVariable(rowSize: Int64(splitLine[2])!, lowerConstraint: Int64(splitLine[3])!, upperConstraint: Int64(splitLine[4])!).makeRandomCase()
            }
        case "col":
            if splitLine[1] == "int"{
                output += ColumnIntVariable(columnSize: Int64(splitLine[2])!, lowerConstraint: Int64(splitLine[3])!, upperConstraint: Int64(splitLine[4])!).makeRandomCase()
            }
        default:
            fatalError("unexpected identifier!")
        }
    }
    return output
}
