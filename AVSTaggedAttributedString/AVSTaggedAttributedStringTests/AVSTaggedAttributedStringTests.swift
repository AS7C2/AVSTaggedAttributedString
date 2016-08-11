//
//  AVSTaggedAttributedStringTests.swift
//  AVSTaggedAttributedString
//
//  Created by Andrei Sherstniuk on 8/8/16.
//
//

import XCTest

import AVSTaggedAttributedString

class AVSTaggedAttributedStringTests: XCTestCase {

#if os(OSX)
    let redColor = NSColor.redColor()
#else
    let redColor = UIColor.redColor()
#endif

    func testEmpty() {
        let s = ""
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1", removeTag: false)
        XCTAssertEqual(NSAttributedString(string: s), (mas.copy() as! NSAttributedString))
    }

    func testWithoutTags() {
        let s = "string"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1", removeTag: true)
        XCTAssertEqual(NSAttributedString(string: s), (mas.copy() as! NSAttributedString))
    }

    func testEmptyWithTagNoRemove() {
        let s = "<tag1></tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1", removeTag: false)
        XCTAssertEqual(NSAttributedString(string: s), (mas.copy() as! NSAttributedString))
    }

    func testEmptyWithTagRemove() {
        let s = "<tag1></tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1", removeTag: true)
        XCTAssertEqual(NSAttributedString(string: "", attributes: [NSFontAttributeName: redColor]), (mas.copy() as! NSAttributedString))
    }

    func testNoEmptyWithTagNoRemove() {
        let s = "<tag1>string</tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1", removeTag: false)
        let expected = NSMutableAttributedString(string: s)
        expected.addAttributes([NSFontAttributeName: redColor], range: NSRange(location: 6, length: 6))
        XCTAssertEqual((expected.copy() as! NSAttributedString), (mas.copy() as! NSAttributedString))
    }
}

