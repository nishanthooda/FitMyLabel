//
//  FitMyLabel.swift
//  FitMyLabel
//
//  Created by Nishant Hooda on 2018-06-26.
//  Copyright © 2018 nishanthooda. All rights reserved.
//

import Foundation

public func splitToFit (str: String, label: UILabel) -> [String]
{
    var splitArray: [String] = []
    
    var perfectFitTuple = findPerfectFit(str: str, label: label)
    
    var perfectFit = perfectFitTuple.0
    var remaining = perfectFitTuple.1
    
    splitArray.append(perfectFit)
    
    while (remaining != "")
    {
        perfectFitTuple = findPerfectFit(str: remaining, label: label)
        
        perfectFit = perfectFitTuple.0
        remaining = perfectFitTuple.1
        
        splitArray.append(perfectFit)
    }
    
    return splitArray
}

private func findPerfectFit (str: String, label: UILabel) -> (String, String)
{
    if !str.isTruncating(label: label)
    {
        return (str , "")
    }
    
    let indices = indicesOfSpaces(str: str)
    
    var low = 0
    var high = indices.count - 1
    
    while (high > low)
    {
        let mid = low+((high-low)/2)
        
        let substr = str[0..<indices[mid]]
        let substrMinusOne = str[0..<indices[mid-1]]
        let substrPlusOne = str[0..<indices[mid+1]]
        
        let substrTruncating = substr.isTruncating(label: label)
        let substrPlusOneTruncating = substrPlusOne.isTruncating(label: label)
        let substrMinusOneTruncating = substrMinusOne.isTruncating(label: label)
        
        //if substr is perfect fit
        if !substrTruncating && substrPlusOneTruncating
        {
            let remains = str[indices[mid]..<str.count]
            return (substr, remains)
        }
        //if substrMinusOne is perfect fit
        else if substrTruncating && !substrMinusOneTruncating
        {
            let remains = str[indices[mid-1]..<str.count]
            return (substrMinusOne, remains)
        }
        //if too big and not perfect fit
        else if substrTruncating
        {
            high = mid - 1
        }
        //if too small and not perfect fit
        else if !substrTruncating
        {
            low = mid + 1
        }
    }
    
    return ("" , "")
}

private func indicesOfSpaces(str: String) -> [Int]
{
    var indices: [Int] = []
    
    for (index, char) in str.enumerated()
    {
        if char == " " || char == "\n"
        {
            indices.append(index)
        }
    }
    
    return indices
}

extension String
{
    func isTruncating(label: UILabel) -> Bool
    {
        let dummyLabel = label
        dummyLabel.text = self
        
        return dummyLabel.isTruncated()
    }
    
    subscript (range: Range<Int>) -> String
    {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        let range = startIndex..<endIndex
        
        return String(self[range])
    }
}

extension UILabel
{
    func isTruncated() -> Bool
    {
        guard let labelText = text else { return false }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
