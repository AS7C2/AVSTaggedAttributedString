//
//  AVSTaggedAttributedString.swift
//  AVSTaggedAttributedString
//
//  Created by Andrei Sherstniuk on 8/8/16.
//
//

import Foundation

extension NSRange {
    var avs_isFound: Bool {
        get {
            return self.location != NSNotFound
        }
    }

    func avs_isBefore(range range: NSRange) -> Bool {
        return self.location + self.length <= range.location
    }

    static func avs_between(range1 range1: NSRange, range2: NSRange) -> NSRange {
        let location = range1.location + range1.length
        let length = range2.location - location
        return NSRange(location: location, length: length)
    }
}

extension NSMutableAttributedString {
    func avs_addAttributes(attributes: [String: AnyObject], tag: String) {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"

        var string = self.mutableString
        var openRange = string.rangeOfString(openTag)
        var closeRange = string.rangeOfString(closeTag)
        while openRange.avs_isFound && closeRange.avs_isFound && openRange.avs_isBefore(range: closeRange) {
            let rangeBetween = NSRange.avs_between(range1: openRange, range2: closeRange)

            self.replaceCharactersInRange(closeRange, withString: "")
            self.replaceCharactersInRange(openRange, withString: "")

            let rangeBetweenWithRemovedTags = NSRange(location: openRange.location, length: rangeBetween.length)
            self.addAttributes(attributes, range: rangeBetweenWithRemovedTags)

            string = self.mutableString
            openRange = string.rangeOfString(openTag)
            closeRange = string.rangeOfString(closeTag)
        }
    }
}