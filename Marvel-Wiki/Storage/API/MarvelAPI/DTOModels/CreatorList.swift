//
// CreatorList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct CreatorList: Codable {

    /** The number of total available creators in this list. Will always be greater than or equal to the \&quot;returned\&quot; value. */
    public var available: Int?
    /** The number of creators returned in this collection (up to 20). */
    public var returned: Int?
    /** The path to the full list of creators in this collection. */
    public var collectionURI: String?
    /** The list of returned creators in this collection. */
    public var items: [CreatorSummary]?

    public init(available: Int?, returned: Int?, collectionURI: String?, items: [CreatorSummary]?) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }


}

