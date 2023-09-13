//
//  main.swift
//  compatitive-random-test
//
//  Created by 北舘友頼 on 2023/04/11.
//

import Foundation
func main(){
    print("How many tests do you want to make? :")
    let loopTimes = Int64(readLine()!)!
    for _ in 0..<loopTimes{
        var parsed = parse()
        print(parsed)
    }
}
main()
