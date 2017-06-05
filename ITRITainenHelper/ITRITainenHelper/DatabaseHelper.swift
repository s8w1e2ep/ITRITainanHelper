//
//  DatabaseHelper.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/6/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON


class DatabaseHelper {

    var db_name: String!
    var db_pathName: String!
    private static let DB_VERSION = 2
    public static let KEYWORD_ADMINISTRATIVE_CATEGORY_RANK = 1
    public static let KEYWORD_QUICK_SERVICE_RANK = 2
    public static let KEYWORD_FACILITY_RANK = 3
    
    // initializer
    init() {
        self.db_name = Constants.DB_NAME
        self.db_pathName = Constants.DATABASE_PATH + self.db_name
    }
    
    init(name: String) {
        self.db_name = name
        self.db_pathName = "\(Constants.DATABASE_PATH)/\(self.db_name)"
    }
    
    func createDB() -> Void {
        createAllTables()
    }
    
    
    // MARK: - create tables
    func createAllTables() -> Void {
        createAdministrativeUnitTable()
        createAdministrativeUnitCategoryTable()
        createAdministrativeUnitInCategoryTable()
        createEDMTable()
        createHotTable()
        createInKeywordTable()
        createInstructionTable()
        createKeywordTable()
        createMappingKeywordTable()
        createMobileAppTable()
    }
    
    // create administrativeUnit table
    func createAdministrativeUnitTable() -> Void {
        do {
            // create table
            let db = try Connection(self.db_pathName)
            let administrativeUnitTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            try db.run(administrativeUnitTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.x)
                t.column(DBColExpressions.y)
                t.column(DBColExpressions.fieldId)
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.parentUnitId)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.tel)
                t.column(DBColExpressions.fax)
                t.column(DBColExpressions.email)
                t.column(DBColExpressions.website)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.iconName)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
                t.column(DBColExpressions.nearByPathId)
                t.column(DBColExpressions.keyword)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT) error.")
        }
    }
    
    // create administrativeUnitCategory Table
    func createAdministrativeUnitCategoryTable() -> Void {
        
        do {
            let db = try Connection(self.db_pathName)
            let administrativeUnitCategory = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)

            try db.run(administrativeUnitCategory.create(ifNotExists: true) { t in
                t.column(DBColExpressions.categoryId)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.iconName)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
                t.column(DBColExpressions.keyword)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) failed.")
        }
    }
    
    // create administrativeUnitInCategory Table
    func createAdministrativeUnitInCategoryTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let administrativeUnitInCategory = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)

            try db.run(administrativeUnitInCategory.create(ifNotExists: true) { t in
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.categoryId)
                t.column(DBColExpressions.lastUpdateTime)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) fail.")
        }
    }
    
    // create Edm Table
    func createEDMTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let edmTable = Table(DBCol.TABLE_EDM)
            try db.run(edmTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.edmId)
                t.column(DBColExpressions.edmName)
                t.column(DBColExpressions.edmURL)
                t.column(DBColExpressions.edmImage)
                t.column(DBColExpressions.edmEndDay)
                t.column(DBColExpressions.lastUpdateTime)
            })
            print("create \(DBCol.TABLE_EDM) succeeded.")
        } catch {
            print("create \(DBCol.TABLE_EDM) fail.")
        }
    }
    
    // create Hot Table
    func createHotTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let hotTable = Table(DBCol.TABLE_HOT)
            try db.run(hotTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.id, primaryKey: .autoincrement)
                t.column(DBColExpressions.hotDate)
                t.column(DBColExpressions.hotTitle)
                t.column(DBColExpressions.hotDescription)
                t.column(DBColExpressions.hotLink)
                t.column(DBColExpressions.isDelete, defaultValue: 0)
            })
            print("create Hot Table succeeded.")
        } catch {
            print("create Hot Table fail.")
        }
    }
    
    // create InKeyword Table
    func createInKeywordTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let inKeywordTable = Table(DBCol.TABLE_IN_KEYWORD)

            try db.run(inKeywordTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.stringId)
                t.column(DBColExpressions.keywordId)
                t.column(DBColExpressions.lastUpdateTime)
            })
            print("create inKeyword Table succeeded.")
        } catch {
            print("create inKeyword Table fail.")
        }
    }
    
    // create instruction Table
    func createInstructionTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let instructionTable = Table(DBCol.TABLE_INSTRUCTION)
            try db.run(instructionTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.id, unique: true)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.read, defaultValue: 0)
            })
            print("create instruction Table succeeded.")
        } catch {
            print("create instruction Table fail.")
        }
        
    }
    
    // create keyword table
    func createKeywordTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let keywordTable = Table(DBCol.TABLE_KEYWORD)
            try db.run(keywordTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.keywordId)
                t.column(DBColExpressions.keyword)
                t.column(DBColExpressions.rank)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
            })
            print("create Keyword Table succeeded.")
        } catch {
            print("create Keyword Table fail.")
        }
    }
    
    // create mapping keyword table
    func createMappingKeywordTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let mappingKeywordTable = Table("mappingKeyword")
            try db.run(mappingKeywordTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.keyword)
            })
            print("create mapping keyword table succeeded.")
        } catch {
            print("create mapping keyword table failed.")
        }
    }
    
    // create mobile app table
    func createMobileAppTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let mobileAppTable = Table(DBCol.TABLE_MOBILEAPP)
            try db.run(mobileAppTable.create(ifNotExists: true) { t in
                t.column(DBColExpressions.appId)
                t.column(DBColExpressions.appName)
                t.column(DBColExpressions.appIOSUrl)
                t.column(DBColExpressions.appImage)
                t.column(DBColExpressions.lastUpdateTime)
            })
            print("create mobile app Table succeeded.")
        } catch {
            print("create mobile app Table fail.")
        }
    }
    
    // create search cache table
    func createSearchCacheTable() -> Void {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_SEARCH_CACHE)
            try db.run(table.create(ifNotExists: true) { t in
                t.column(DBColExpressions.searchKeyword)
            })
            print("create search cache table succeeded.")
        } catch {
            print("create search cache table fail.")
        }
    }
    
    
    
    // MARK: - insert or update
    // cannot insert into this table
    func insertOrUpdateAdministrativeUnitTable(x: Int64, y: Int64, fieldId: String, unitId: String, parentUnitId: String, name: String, tel: String, fax: String, email: String, website: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, nearByPathId: String, keyword: String) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            let filtering = table.filter(DBColExpressions.unitId == unitId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.unitId == unitId)
                try db.run(updateFilter.update(DBColExpressions.x <- x, DBColExpressions.y <- y, DBColExpressions.fieldId <- fieldId, DBColExpressions.parentUnitId <- parentUnitId, DBColExpressions.name <- name, DBColExpressions.tel <- tel, DBColExpressions.fax <- fax, DBColExpressions.email <- email, DBColExpressions.website <- website, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.nearByPathId <- nearByPathId, DBColExpressions.keyword <- keyword))
//                print("update data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT), unitId = \(unitId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.x <- x, DBColExpressions.y <- y, DBColExpressions.fieldId <- fieldId, DBColExpressions.unitId <- unitId, DBColExpressions.parentUnitId <- parentUnitId, DBColExpressions.name <- name, DBColExpressions.tel <- tel, DBColExpressions.fax <- fax, DBColExpressions.email <- email, DBColExpressions.website <- website, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.nearByPathId <- nearByPathId, DBColExpressions.keyword <- keyword))
//                print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT), unitId = \(unitId)")
            }
            return true
        } catch _ {
            print("insert/update administrative unit table error, unitId = \(unitId).")
            return false
        }
    }
    
    func insertOrUpdateAdministrativeUnitCategory(categoryId: String, name: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, keyword: String) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            let filtering = table.filter(DBColExpressions.categoryId == categoryId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.categoryId == categoryId)
                try db.run(updateFilter.update(DBColExpressions.name <- name, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.keyword <- keyword))
//                print("update data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), categoryId = \(categoryId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.categoryId <- categoryId, DBColExpressions.name <- name, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.keyword <- keyword))
//                print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), categoryId = \(categoryId)")
            }
            return true
        } catch _ {
            print("insert/update administrative unit category table error, categoryId = \(categoryId).")
            return false
        }
    }
    
    func insertOrUpdateAdministrativeUnitInCategory(unitId: String, categoryId: String, lastUpdateTime: Int64) -> Bool{
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)
            let filtering = table.filter(DBColExpressions.unitId == unitId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.unitId == unitId)
                try db.run(updateFilter.update(DBColExpressions.categoryId <- categoryId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("update data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY), unitId = \(unitId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.unitId <- unitId, DBColExpressions.categoryId <- categoryId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY), unitId = \(unitId)")
            }
            return true
        } catch _ {
            print("insert/update administrative unit in category table error, unitId = \(unitId).")
            return false
        }
    }
    
    func insertOrUpdateEdmTable(edmId: String, edmName: String, edmURL: String, edmImage: String, edmEndDay: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_EDM)
            let filtering = table.filter(DBColExpressions.edmId == edmId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.edmId == edmId)
                try db.run(updateFilter.update(DBColExpressions.edmName <- edmName, DBColExpressions.edmURL <- edmURL, DBColExpressions.edmImage <- edmImage, DBColExpressions.edmEndDay <- edmEndDay, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("update data to \(DBCol.TABLE_EDM), edmId = \(edmId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.edmId <- edmId, DBColExpressions.edmName <- edmName, DBColExpressions.edmURL <- edmURL, DBColExpressions.edmImage <- edmImage, DBColExpressions.edmEndDay <- edmEndDay, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("insert data to \(DBCol.TABLE_EDM), edmId = \(edmId)")
            }
            return true
        } catch _ {
            print("insert/update edm table error, edmId = \(edmId).")
            return false
        }
    }
    
    func insertOrUpdateHotTable(id: Int64, hotDate: String, hotTitle: String, hotDescription: String, hotLink: String, isDelete: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_HOT)
            let filtering = table.filter(DBColExpressions.id == id).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.id == id)
                try db.run(updateFilter.update(DBColExpressions.hotDate <- hotDate, DBColExpressions.hotTitle <- hotTitle, DBColExpressions.hotDescription <- hotDescription, DBColExpressions.hotLink <- hotLink, DBColExpressions.isDelete <- isDelete))
//                print("update data to \(DBCol.TABLE_HOT), id = \(id)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.id <- id, DBColExpressions.hotDate <- hotDate, DBColExpressions.hotTitle <- hotTitle, DBColExpressions.hotDescription <- hotDescription, DBColExpressions.hotLink <- hotLink, DBColExpressions.isDelete <- isDelete))
//                print("insert data to \(DBCol.TABLE_HOT), id = \(id)")
            }
            return true
        } catch _ {
            print("insert/update hot table error, id = \(id).")
            return false
        }
    }
    
    func insertOrUpdateInKeywordTable(id : String, keywordId: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_IN_KEYWORD)
            // try insert/replace
            let filtering = table.filter(DBColExpressions.stringId == id).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.stringId == id)
                try db.run(updateFilter.update(DBColExpressions.keywordId <- keywordId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("update data to \(DBCol.TABLE_IN_KEYWORD), stringId = \(id)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.stringId <- id, DBColExpressions.keywordId <- keywordId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("insert data to \(DBCol.TABLE_IN_KEYWORD), stringId = \(id)")
            }
            return true
        } catch _ {
            print("insert/update in keyword table error, stringId = \(id).")
            return false
        }
    }
    
    func insertOrUpdateInstructionTable(id: Int64, name: String, read: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_INSTRUCTION)
            let filtering = table.filter(DBColExpressions.id == id).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.id == id)
                try db.run(updateFilter.update(DBColExpressions.name <- name, DBColExpressions.read <- read))
//                print("update data to \(DBCol.TABLE_INSTRUCTION), id = \(id)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.id <- id, DBColExpressions.name <- name, DBColExpressions.read <- read))
//                print("insert data to \(DBCol.TABLE_INSTRUCTION), id = \(id)")
            }
            return true
        } catch _ {
            print("insert/update instruction table error, id = \(id).")
            return false
        }
    }
    
    func insertOrUpdateKeywordTable(keywordId: String, keyword: String, rank: Int64, description: String, createTime: Int64, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_KEYWORD)
            let filtering = table.filter(DBColExpressions.keywordId == keywordId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.keywordId == keywordId)
                try db.run(updateFilter.update(DBColExpressions.keyword <- keyword, DBColExpressions.rank <- rank, DBColExpressions.description <- description, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("update data to \(DBCol.TABLE_KEYWORD), keywordId = \(keywordId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.keywordId <- keywordId, DBColExpressions.keyword <- keyword, DBColExpressions.rank <- rank, DBColExpressions.description <- description, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("insert data to \(DBCol.TABLE_KEYWORD), keywordId = \(keywordId)")
            }
            return true
        } catch _ {
            print("insert/update keyword table error, keywordId = \(keywordId).")
            return false
        }
    }
    
    func insertOrUpdateMappingKeywordTable(unitId: String, keyword: String) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table("mappingKeyword")
            let filtering = table.filter(DBColExpressions.unitId == unitId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                let updateFilter = table.filter(DBColExpressions.unitId == unitId)
                try db.run(updateFilter.update(DBColExpressions.keyword <- keyword))
//                print("update data to mappingKeyword, unitId = \(unitId)")
            } else {
                try db.run(table.insert(or: .replace, DBColExpressions.unitId <- unitId, DBColExpressions.keyword <- keyword))
//                print("insert data to mappingKeyword, unitId = \(unitId)")
            }
            return true
        } catch _ {
            print("insert/update mapping keyword table error, unitId = \(unitId).")
        }
        return false
    }
    
    func insertOrUpdateMobileAppTable(appId: String, appName: String, appIOSUrl: String, appImage: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_MOBILEAPP)
            let filtering = table.filter(DBColExpressions.appId == appId).limit(1)
            let plucking = try db.pluck(filtering)
            if (plucking != nil) {
                // update if there is row
                let updateFilter = table.filter(DBColExpressions.appId == appId)
                try db.run(updateFilter.update(DBColExpressions.appName <- appName, DBColExpressions.appIOSUrl <- appIOSUrl, DBColExpressions.appImage <- appImage, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("update data to \(DBCol.TABLE_MOBILEAPP), appId = \(appId)")
            } else {
                // else insert if there is no existing row
                try db.run(table.insert(or: .replace, DBColExpressions.appId <- appId, DBColExpressions.appName <- appName, DBColExpressions.appIOSUrl <- appIOSUrl, DBColExpressions.appImage <- appImage, DBColExpressions.lastUpdateTime <- lastUpdateTime))
//                print("insert data to \(DBCol.TABLE_MOBILEAPP), appId = \(appId)")
            }
            return true
        } catch _ {
            print("insert/update mobile app table error, appId = \(appId).")
            return false
        }
    }
    
    
    
    // MARK: - query functions
    // return NSMutableArray[AdministrativeUnit]
    func queryAdministrativeUnitTable() -> NSMutableArray {
        let administrativeUnits = NSMutableArray()
        do {
            let administrative_table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            let db = try Connection(self.db_pathName)
            for admin_unit in try db.prepare(administrative_table) {
                let adminUnit = AdministrativeUnit(x: admin_unit[DBColExpressions.x], y: admin_unit[DBColExpressions.y], fieldId: admin_unit[DBColExpressions.fieldId], unitId: admin_unit[DBColExpressions.unitId], parentUnitId: admin_unit[DBColExpressions.parentUnitId], name: admin_unit[DBColExpressions.name], tel: admin_unit[DBColExpressions.tel], fax: admin_unit[DBColExpressions.fax], email: admin_unit[DBColExpressions.email], website: admin_unit[DBColExpressions.website], description: admin_unit[DBColExpressions.description], iconName: admin_unit[DBColExpressions.iconName], createTime: admin_unit[DBColExpressions.createTime], lastUpdateTime: admin_unit[DBColExpressions.lastUpdateTime], nearByPathId: admin_unit[DBColExpressions.nearByPathId], keyword: admin_unit[DBColExpressions.keyword])
                administrativeUnits.add(adminUnit)
            }
        } catch _ {
            print("query administrative unit table fail.")
        }
        return administrativeUnits
    }
    
    // return NSMutableArray[AdministrativeUnit]
    func queryAdministrativeUnitByCategoryId(categoryId: String) -> NSMutableArray {
        // TODO: - test
        let administrativeUnits = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            let filter = table.filter(DBColExpressions.categoryId == categoryId)
            for admin_unit in try db.prepare(filter) {
                let adminUnit = AdministrativeUnit(x: admin_unit[DBColExpressions.x], y: admin_unit[DBColExpressions.y], fieldId: admin_unit[DBColExpressions.fieldId], unitId: admin_unit[DBColExpressions.unitId], parentUnitId: admin_unit[DBColExpressions.parentUnitId], name: admin_unit[DBColExpressions.name], tel: admin_unit[DBColExpressions.tel], fax: admin_unit[DBColExpressions.fax], email: admin_unit[DBColExpressions.email], website: admin_unit[DBColExpressions.website], description: admin_unit[DBColExpressions.description], iconName: admin_unit[DBColExpressions.iconName], createTime: admin_unit[DBColExpressions.createTime], lastUpdateTime: admin_unit[DBColExpressions.lastUpdateTime], nearByPathId: admin_unit[DBColExpressions.nearByPathId], keyword: admin_unit[DBColExpressions.keyword])
                administrativeUnits.add(adminUnit)
            }
        } catch _ {
            print("query administrative unit table fail.")
        }
        return administrativeUnits
    }
    
    func queryAdministrativeUnitCategoryTable() -> NSMutableArray {
        let administrativeUnitCategories = NSMutableArray()
        do {
            let administrativeUnitCategoryTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            let db = try Connection(self.db_pathName)
            for categories in try db.prepare(administrativeUnitCategoryTable) {
                let adminUnitCategory = AdministrativeUnitCategory(categoryId: categories[DBColExpressions.categoryId], name: categories[DBColExpressions.name], description: categories[DBColExpressions.description], iconName: categories[DBColExpressions.iconName], createTime: categories[DBColExpressions.createTime], lastUpdateTime: categories[DBColExpressions.lastUpdateTime], keyword: categories[DBColExpressions.keyword])
                administrativeUnitCategories.add(adminUnitCategory)
            }
        } catch _ {
            print("query administrative unit category table fail.")
        }
        return administrativeUnitCategories
    }
    
    // return lots of
    func queryAdministrativeUnitCategoryByRank(rank: Int) -> NSMutableArray {
        // TODO: - test
        let array = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let stmt = try db.prepare("SELECT auc.* FROM \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) auc, \(DBCol.TABLE_KEYWORD) k, \(DBCol.TABLE_IN_KEYWORD) ik, WHERE k.rank=\(rank) AND ik.keywordId=k.keywordId AND ik.id=auc.categoryId AND auc.categoryId=auc.categroyId")
            // todo: need to return data
            for row in stmt {
                for (index, name) in stmt.columnNames.enumerated() {
                    print("\(name) = \(row[index]!)")
                }
                array.add(row)
            }
        } catch _ {
            print("query administrative unit category with rank: \(rank) error.")
        }
        return array
    }
    
    func testQueryCategoryId(rank: Int64) -> NSMutableArray {
        let array = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let keywordTable = Table(DBCol.TABLE_KEYWORD)
            let adminCategoryTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            let inKeywordTable = Table(DBCol.TABLE_IN_KEYWORD)
            
            // alias
            let auc = adminCategoryTable.alias("auc")
            let k = keywordTable.alias("k")
            let ik = inKeywordTable.alias("ik")
            
            let joinKeywordId = ik.join(k, on: k[DBColExpressions.keywordId] == ik[DBColExpressions.keywordId])
            let joinCategoryId = auc.join(joinKeywordId, on: joinKeywordId[DBColExpressions.stringId] == auc[DBColExpressions.categoryId])
            let joinAll = joinCategoryId.filter(DBColExpressions.rank == rank)
            for items in try db.prepare(joinAll) {
                let item = AdministrativeUnitCategory(categoryId: items.get(DBColExpressions.categoryId), name: items.get(DBColExpressions.name), description: items.get(DBColExpressions.description), iconName: items.get(DBColExpressions.iconName), createTime: items.get(DBColExpressions.createTime), lastUpdateTime: items.get(DBColExpressions.lastUpdateTime))
                array.add(item)
            }
            //        res = db.rawQuery("SELECT auc.* FROM " + DbCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY + " auc, " +
            //        DbCol.TABLE_KEYWORD + " k, " +
            //            DbCol.TABLE_INKEYWORD + " ik " +
            //            " WHERE k.rank=" + rank + " AND ik.keywordId=k.keywordId AND ik.id=auc.categoryId AND auc.categoryId=auc.categoryId", null);
        } catch _ {
            print("query categoryId error.")
        }
        return array
    }
    
    
    func queryAdministrativeUnitInCategoryTable() -> NSMutableArray {
        let unitInCategories = NSMutableArray()
        do {
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)
            let db = try Connection(self.db_pathName)
            for rows in try db.prepare(table) {
                let data = AdministrativeUnitInCategory(unitId: rows[DBColExpressions.unitId], categoryId: rows[DBColExpressions.categoryId], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                unitInCategories.add(data)
            }
        } catch _ {
            print("query administrative unit in category table fail.")
        }
        return unitInCategories
    }
    
    func queryEdmTable() -> NSMutableArray {
        let edms = NSMutableArray()
        do {
            let table = Table(DBCol.TABLE_EDM)
            let db = try Connection(self.db_pathName)
            for rows in try db.prepare(table) {
                let data = Edm(edmId: rows[DBColExpressions.edmId], edmName: rows[DBColExpressions.edmName], edmURL: rows[DBColExpressions.edmURL], edmImage: rows[DBColExpressions.edmImage], edmEndDay: rows[DBColExpressions.edmEndDay], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                edms.add(data)
            }
        } catch _ {
            print("query edm table fail.")
        }
        return edms
    }
    
    func queryHotTable() -> NSMutableArray {
        let hots = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_HOT)
            for rows in try db.prepare(table) {
                let data = HotItem(id: rows[DBColExpressions.id], hotDate: rows[DBColExpressions.hotDate], hotTitle: rows[DBColExpressions.hotTitle], hotDescription: rows[DBColExpressions.hotDescription], hotLink: rows[DBColExpressions.hotLink], isDelete: rows[DBColExpressions.isDelete])
                hots.add(data)
            }
        } catch _ {
            print("query hot table fail.")
        }
        return hots
    }
    
    func queryInKeywordTable() -> NSMutableArray {
        let inKeywords = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_IN_KEYWORD)
            for rows in try db.prepare(table) {
                let data = InKeywords(stringId: String(rows[DBColExpressions.stringId]), keywordId: rows[DBColExpressions.keywordId], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                inKeywords.add(data)
            }
        } catch _ {
            print("query in keyword table fail.")
        }
        return inKeywords
    }
    
    func queryInstructionTable() -> NSMutableArray {
        let instructions = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_INSTRUCTION)
            for rows in try db.prepare(table) {
                let data = InstructionItem(id: rows[DBColExpressions.id], name: rows[DBColExpressions.name], read: rows[DBColExpressions.read])
                instructions.add(data)
            }
        } catch _ {
            print("query instruction table fail.")
        }
        return instructions
    }
    
    func queryKeywordTable() -> NSMutableArray {
        let keywords = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_KEYWORD)
            for rows in try db.prepare(table) {
                let data = Keyword(keywordId: rows[DBColExpressions.keywordId], keyword: rows[DBColExpressions.keyword], rank: rows[DBColExpressions.rank], description: rows[DBColExpressions.description], createTime: rows[DBColExpressions.createTime], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                keywords.add(data)
            }
        } catch _ {
            print("query keyword table fail.")
        }
        return keywords
    }
    
    func queryMappingKeywordTable() -> NSMutableArray {
        let mappings = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table("mappingKeyword")
            for rows in try db.prepare(table) {
                let data = MappingKeyword(unitId: rows[DBColExpressions.unitId], keyword: rows[DBColExpressions.keyword])
                mappings.add(data)
            }
        } catch _ {
            print("query mapping keyword table fail.")
        }
        return mappings
    }
    
    func queryMobileAppTable() -> NSMutableArray {
        let apps = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_MOBILEAPP)
            for rows in try db.prepare(table) {
                let data = MobileApps(appId: rows[DBColExpressions.appId], appName: rows[DBColExpressions.appName], appIOSUrl: rows[DBColExpressions.appIOSUrl], appImage: rows[DBColExpressions.appImage], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                apps.add(data)
            }
        } catch _ {
            print("query mobileapp table fail.")
        }
        return apps
    }
    
    func getFacilities() -> NSMutableArray {
        return queryAdministrativeUnitCategoryByRank(rank: DatabaseHelper.KEYWORD_FACILITY_RANK)
    }
    
    func getQuickServices() -> NSMutableArray {
        return queryAdministrativeUnitCategoryByRank(rank: DatabaseHelper.KEYWORD_QUICK_SERVICE_RANK)
    }
    
    func getAdministrativeCategories() -> NSMutableArray {
        return queryAdministrativeUnitCategoryByRank(rank: DatabaseHelper.KEYWORD_ADMINISTRATIVE_CATEGORY_RANK)
    }
    
    // TODO: - test
    func searchAdminUnitsByKeyword(keyword: String) -> NSMutableArray {
        let array = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            // filter: select where keyword like %keyword%
            let filter = table.filter(DBColExpressions.name.like("'%\(keyword)%'"))
            for admin_unit in try db.prepare(filter) {
                let data = AdministrativeUnit(x: admin_unit[DBColExpressions.x], y: admin_unit[DBColExpressions.y], fieldId: admin_unit[DBColExpressions.fieldId], unitId: admin_unit[DBColExpressions.unitId], parentUnitId: admin_unit[DBColExpressions.parentUnitId], name: admin_unit[DBColExpressions.name], tel: admin_unit[DBColExpressions.tel], fax: admin_unit[DBColExpressions.fax], email: admin_unit[DBColExpressions.email], website: admin_unit[DBColExpressions.website], description: admin_unit[DBColExpressions.description], iconName: admin_unit[DBColExpressions.iconName], createTime: admin_unit[DBColExpressions.createTime], lastUpdateTime: admin_unit[DBColExpressions.lastUpdateTime], nearByPathId: admin_unit[DBColExpressions.nearByPathId], keyword: admin_unit[DBColExpressions.keyword])
                array.add(data)
            }
        } catch _ {
            print("search administrative units by: \(keyword) error.")
        }
        return array
    }
    
    // TODO: - test
    func searchAdminUnits(keyword: String) -> NSMutableArray {
        let trimmedKeyword = keyword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (keyword.characters.count == 0) {
            return NSMutableArray()
        }
        
        var nameLikeCondition = ""
        var descriptionLikeCondition = ""
        for token in trimmedKeyword.components(separatedBy: " ") {
            // unit name like
            if nameLikeCondition != "" {
                nameLikeCondition += " OR "
            }
            nameLikeCondition += ("'%" + token + "%'")
            
            // description like
            if descriptionLikeCondition != "" {
                descriptionLikeCondition += " OR "
            }
            descriptionLikeCondition += ("'%" + token + "%'")
        }
        
        let dataArray = NSMutableArray()
        // query
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            // where name like
            let filtering = table.filter(DBColExpressions.name.like(nameLikeCondition) && DBColExpressions.description.like(descriptionLikeCondition))
            for admin_unit in try db.prepare(filtering) {
                let data = AdministrativeUnit(x: admin_unit[DBColExpressions.x], y: admin_unit[DBColExpressions.y], fieldId: admin_unit[DBColExpressions.fieldId], unitId: admin_unit[DBColExpressions.unitId], parentUnitId: admin_unit[DBColExpressions.parentUnitId], name: admin_unit[DBColExpressions.name], tel: admin_unit[DBColExpressions.tel], fax: admin_unit[DBColExpressions.fax], email: admin_unit[DBColExpressions.email], website: admin_unit[DBColExpressions.website], description: admin_unit[DBColExpressions.description], iconName: admin_unit[DBColExpressions.iconName], createTime: admin_unit[DBColExpressions.createTime], lastUpdateTime: admin_unit[DBColExpressions.lastUpdateTime], nearByPathId: admin_unit[DBColExpressions.nearByPathId], keyword: admin_unit[DBColExpressions.keyword])
                dataArray.add(data)
            }
        } catch _ {
            print("query administrative unit with keyword: \(keyword) fail.")
        }
        return dataArray
    }
    
    
    
    // MARK: - sync tables
    func getLastUpdateTime(tableName: String) -> NSInteger {
        var lastTime = NSInteger(0)
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(tableName)
            // query "lastUpdateTime" column for the designated table: SELECT lastUpdateTime FROM tableName ORDER BY lastUpdateTime DESC LIMIT 1
            let query = table.select(DBColExpressions.lastUpdateTime).order(DBColExpressions.lastUpdateTime.desc).limit(1)
            let count = 1
            // get first row
            for times in try db.prepare(query) {
                if (count == 1) {
                    lastTime = NSInteger(times[DBColExpressions.lastUpdateTime])
                    break
                }
            }
        } catch _ {
            print("query lastUpdateTime error, return lastUpdateTime = \(lastTime)")
        }
        return lastTime
    }
    
    // administrative unit
    func syncAdministrativeUnitTable(jsonObj: JSON) {
        let result = jsonObj["result"].intValue
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateAdministrativeUnit(jsonObj: dict.1)
            }
        }
    }
    
    func updateAdministrativeUnit(jsonObj: JSON) {
        do {
            // pluck a row: if there is data
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            if (jsonObj["isDelete"].intValue == 0) {
                /* perform insert or update */
                // pluck to check if the row exists
                let filtering = table.filter(DBColExpressions.unitId == jsonObj["unitId"].stringValue).limit(1)
                let plucking = try db.pluck(filtering)
                if (plucking != nil) {
                    // update if there is row
                    let updateFilter = table.filter(DBColExpressions.unitId == jsonObj["unitId"].stringValue)
                    try db.run(updateFilter.update(DBColExpressions.parentUnitId <- jsonObj["parentUnitId"].stringValue, DBColExpressions.name <- jsonObj["name"].stringValue, DBColExpressions.fieldId <- jsonObj["fieldId"].stringValue, DBColExpressions.x <- jsonObj["x"].int64Value, DBColExpressions.y <- jsonObj["y"].int64Value, DBColExpressions.nearByPathId <- jsonObj["nearByPathId"].stringValue, DBColExpressions.tel <- jsonObj["tel"].stringValue, DBColExpressions.fax <- jsonObj["fax"].stringValue, DBColExpressions.email <- jsonObj["email"].stringValue, DBColExpressions.website <- jsonObj["website"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.iconName <- jsonObj["iconName"].stringValue, DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("update data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT), unitId = \(jsonObj["unitId"].stringValue)")
                } else {
                    // else insert if there is no existing row
                    try db.run(table.insert(DBColExpressions.unitId <- jsonObj["unitId"].stringValue, DBColExpressions.parentUnitId <- jsonObj["parentUnitId"].stringValue, DBColExpressions.name <- jsonObj["name"].stringValue, DBColExpressions.fieldId <- jsonObj["fieldId"].stringValue, DBColExpressions.x <- jsonObj["x"].int64Value, DBColExpressions.y <- jsonObj["y"].int64Value, DBColExpressions.nearByPathId <- jsonObj["nearByPathId"].stringValue, DBColExpressions.tel <- jsonObj["tel"].stringValue, DBColExpressions.fax <- jsonObj["fax"].stringValue, DBColExpressions.email <- jsonObj["email"].stringValue, DBColExpressions.website <- jsonObj["website"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.iconName <- jsonObj["iconName"].stringValue, DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT), unitId = \(jsonObj["unitId"].stringValue)")
                }
            } else {
                /* perform delete action */
                // filter by unitId
                let deleteUnitId = table.filter(DBColExpressions.unitId == jsonObj["unitId"].stringValue)
                do {
                    if try db.run(deleteUnitId.delete()) > 0 {
//                        print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT) deleted row, unitId: \(jsonObj["unitId"].stringValue)")
                    } else {
//                        print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT), unitId: \(jsonObj["unitId"].stringValue) not found.")
                    }
                } catch {
                    print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT) delete row failed: \(error)")
                }
            }
        } catch _ {
            print("update \(DBCol.TABLE_ADMINISTRATIVE_UNIT) table error, unitId = \(jsonObj["unitId"].stringValue).")
        }
    }
    
    // administrative unit
    func syncAdministrativeUnitCategory(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateAdministrativeUnitCategory(jsonObj: dict.1)
            }
        }
    }
    
    func updateAdministrativeUnitCategory(jsonObj: JSON) {
        do {
            // pluck a row: if there is data
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            if (jsonObj["isDelete"].intValue == 0) {
                /* perform insert or update */
                // pluck to check if the row exists
                let filtering = table.filter(DBColExpressions.categoryId == jsonObj["categoryId"].stringValue).limit(1)
                let plucking = try db.pluck(filtering)
                if (plucking != nil) {
                    // update if there is row
                    let updateFilter = table.filter(DBColExpressions.categoryId == jsonObj["categoryId"].stringValue)
                    try db.run(updateFilter.update(DBColExpressions.name <- jsonObj["name"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.iconName <- jsonObj["iconName"].stringValue, DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("update data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), unitId = \(jsonObj["categoryId"].stringValue)")
                } else {
                    // else insert if there is no existing row
                    try db.run(table.insert(DBColExpressions.categoryId <- jsonObj["categoryId"].stringValue, DBColExpressions.name <- jsonObj["name"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.iconName <- jsonObj["iconName"].stringValue, DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), unitId = \(jsonObj["categoryId"].stringValue)")
                }
            } else {
                /* perform delete action */
                // filter by unitId
                let deleteUnitId = table.filter(DBColExpressions.categoryId == jsonObj["categoryId"].stringValue)
                do {
                    if try db.run(deleteUnitId.delete()) > 0 {
//                        print("delete data \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), categoryId = \(jsonObj["categoryId"].stringValue)")
                    } else {
//                        print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY), categoryId: \(jsonObj["categoryId"].stringValue) not found.")
                    }
                } catch {
                    print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) delete categoryId=\(jsonObj["categoryId"].stringValue) failed: \(error)")
                }
            }
        } catch _ {
            print("update \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) table error, unitId = \(jsonObj["categoryId"].stringValue).")
        }
    }
    
    // administrative unit in category
    func syncAdministrativeUnitInCategory(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateAdministrativeUnitCategory(jsonObj: dict.1)
            }
        }
    }
    
    func updateAdministrativeUnitInCategory(jsonObj: JSON) {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)
            
            // update administrative unit in category: delete unitId then insert a new one
            let deleteFilter = table.filter(DBColExpressions.unitId == jsonObj["unitId"].stringValue)
            if try db.run(deleteFilter.delete()) > 0 {
//                print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) deleted row, unitId: \(jsonObj["unitId"].stringValue)")
            } else {
//                print("\(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY), unitId: \(jsonObj["unitId"].stringValue) not deleted.")
            }
            // insert new row
            try db.run(table.insert(DBColExpressions.unitId <- jsonObj["unitId"].stringValue, DBColExpressions.categoryId <- jsonObj["categoryId"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
            print("insert data to \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY), unitId: \(jsonObj["unitId"].stringValue)")
        } catch _ {
            print("update \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) table error, unitId: \(jsonObj["unitId"].stringValue).")
        }
    }
    
    // keyword table
    func syncKeywordTable(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateKeywordTable(jsonObj: dict.1)
            }
        }
    }
    
    func updateKeywordTable(jsonObj: JSON) {
        do {
            // pluck a row: if there is data
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_KEYWORD)
            if (jsonObj["isDelete"].intValue == 0) {
                /* perform insert or update */
                // pluck to check if the row exists
                let filtering = table.filter(DBColExpressions.keywordId == jsonObj["keywordId"].stringValue).limit(1)
                let plucking = try db.pluck(filtering)
                if (plucking != nil) {
                    // update if there is row
                    let updateFilter = table.filter(DBColExpressions.keywordId == jsonObj["keywordId"].stringValue)
                    try db.run(updateFilter.update(DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.rank <- jsonObj["rank"].int64Value, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("update row in \(DBCol.TABLE_KEYWORD), \(DBColExpressions.keywordId)=\(jsonObj["keywordId"].stringValue)")
                } else {
                    // else insert if there is no existing row
                    try db.run(table.insert(DBColExpressions.keywordId <- jsonObj["keywordId"].stringValue, DBColExpressions.keyword <- jsonObj["keyword"].stringValue, DBColExpressions.description <- jsonObj["description"].stringValue, DBColExpressions.rank <- jsonObj["rank"].int64Value, DBColExpressions.createTime <- jsonObj["createTime"].int64Value, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("insert row into \(DBCol.TABLE_KEYWORD), \(DBColExpressions.keywordId)=\(jsonObj["keywordId"].stringValue)")
                }
            } else {
                /* perform delete action */
                // filter by unitId
                let deleteUnitId = table.filter(DBColExpressions.keywordId == jsonObj["keywordId"].stringValue)
                do {
                    if try db.run(deleteUnitId.delete()) > 0 {
//                        print("\(DBCol.TABLE_KEYWORD) deleted row, keywordId: \(jsonObj["keywordId"].stringValue)")
                    } else {
//                        print("\(DBCol.TABLE_KEYWORD) row keywordId: \(jsonObj["keywordId"].stringValue) not found.")
                    }
                } catch {
                    print("\(DBCol.TABLE_KEYWORD) delete row failed: \(error)")
                }
            }
        } catch _ {
            print("update \(DBCol.TABLE_KEYWORD) table error, \(DBColExpressions.keywordId)=\(jsonObj["keywordId"].stringValue).")
        }
    }
    
    // In Keyword table
    func syncInKeyword(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateInKeyword(jsonObj: dict.1)
            }
        }
    }
    
    func updateInKeyword(jsonObj: JSON) {
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_IN_KEYWORD)
            let deleteFilter = table.filter(DBColExpressions.stringId == jsonObj["stringId"].stringValue)
            if try db.run(deleteFilter.delete()) > 0 {
//                print("\(DBCol.TABLE_IN_KEYWORD) delete row, stringId=\(jsonObj["stringId"].stringValue) success.")
            } else {
//                print("\(DBCol.TABLE_IN_KEYWORD), stringId=\(jsonObj["stringId"]) not found");
            }
            // insert new row
            try db.run(table.insert(DBColExpressions.stringId <- jsonObj["stringId"].stringValue, DBColExpressions.keywordId <- jsonObj["keywordId"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//            print("insert row into \(DBCol.TABLE_IN_KEYWORD), \(DBColExpressions.stringId)=\(jsonObj["stringId"].stringValue)")
        } catch _ {
            print("update \(DBCol.TABLE_IN_KEYWORD) table error, stringId=\(jsonObj["stringId"]).")
        }
    }
    
    // EDM
    func syncEdmTable(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateEdmTable(jsonObj: dict.1)
            }
        }
    }
    
    func updateEdmTable(jsonObj: JSON) {
        print("try edm")
        do {
            // pluck a row: if there is data
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_EDM)
            if (jsonObj["isDelete"].intValue == 0) {
                /* perform insert or update */
                // pluck to check if the row exists
                let filtering = table.filter(DBColExpressions.edmId == jsonObj["edmId"].stringValue).limit(1)
                let plucking = try db.pluck(filtering)
                if (plucking != nil) {
                    // update if there is row
                    let updateFilter = table.filter(DBColExpressions.edmId == jsonObj["edmId"].stringValue)
                    try db.run(updateFilter.update(DBColExpressions.edmName <- jsonObj["edmName"].stringValue, DBColExpressions.edmImage <- jsonObj["edmImage"].stringValue, DBColExpressions.edmURL <- jsonObj["edmURL"].stringValue, DBColExpressions.edmEndDay <- jsonObj["edmEndDay"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("update row in \(DBCol.TABLE_EDM), \(DBColExpressions.edmId)=\(jsonObj["edmId"].stringValue) success.")
                } else {
                    // else insert if there is no existing row
                    try db.run(table.insert(DBColExpressions.edmId <- jsonObj["edmId"].stringValue, DBColExpressions.edmName <- jsonObj["edmName"].stringValue, DBColExpressions.edmURL <- jsonObj["edmURL"].stringValue, DBColExpressions.edmImage <- jsonObj["edmImage"].stringValue, DBColExpressions.edmEndDay <- jsonObj["edmEndDay"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("insert row into \(DBCol.TABLE_EDM), \(DBColExpressions.edmId)=\(jsonObj["edmId"].stringValue) success.")
                }
            } else {
                /* perform delete action */
                // filter by unitId
                let deleteUnitId = table.filter(DBColExpressions.edmId == jsonObj["edmId"].stringValue)
                do {
                    if try db.run(deleteUnitId.delete()) > 0 {
//                        print("\(DBCol.TABLE_EDM) delete row, edmId=\(jsonObj["edmId"].stringValue) success.")
                    } else {
//                        print("\(DBCol.TABLE_EDM) row, edmId=\(jsonObj["edmId"].stringValue) not found.")
                    }
                } catch {
                    print("\(DBCol.TABLE_EDM) delete row: edmId=\(jsonObj["edmId"].stringValue), failed: \(error)")
                }
            }
        } catch _ {
            print("update \(DBCol.TABLE_EDM) table error, \(DBColExpressions.edmId)=\(jsonObj["edmId"].stringValue).")
        }
    }
    
    // mobile app
    func syncMobileApp(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                // 取當下 dictionary 的 value 值 --> JSON
                updateMobileApp(jsonObj: dict.1)
            }
        }
    }
    
    func updateMobileApp(jsonObj: JSON) {
        do {
            // pluck a row: if there is data
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_MOBILEAPP)
            if (jsonObj["isDelete"].intValue == 0) {
                /* perform insert or update */
                // pluck to check if the row exists
                let filtering = table.filter(DBColExpressions.appId == jsonObj["appId"].stringValue).limit(1)
                let plucking = try db.pluck(filtering)
                if (plucking != nil) {
                    // update if there is row
                    let updateFilter = table.filter(DBColExpressions.appId == jsonObj["appId"].stringValue)
                    try db.run(updateFilter.update(DBColExpressions.appName <- jsonObj["appName"].stringValue, DBColExpressions.appImage <- jsonObj["appImage"].stringValue, DBColExpressions.appIOSUrl <- jsonObj["appIOSUrl"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("update row in \(DBCol.TABLE_MOBILEAPP), \(DBColExpressions.appId)=\(jsonObj["appId"].stringValue) success.")
                } else {
                    // else insert if there is no existing row
                    try db.run(table.insert(DBColExpressions.appId <- jsonObj["appId"].stringValue, DBColExpressions.appName <- jsonObj["appName"].stringValue, DBColExpressions.appImage <- jsonObj["appImage"].stringValue, DBColExpressions.appIOSUrl <- jsonObj["appIOSUrl"].stringValue, DBColExpressions.lastUpdateTime <- jsonObj["lastUpdateTime"].int64Value))
//                    print("insert row into \(DBCol.TABLE_MOBILEAPP), \(DBColExpressions.appId)=\(jsonObj["appId"].stringValue) success.")
                }
            } else {
                /* perform delete action */
                // filter by unitId
                let deleteUnitId = table.filter(DBColExpressions.appId == jsonObj["appId"].stringValue)
                do {
                    if try db.run(deleteUnitId.delete()) > 0 {
//                        print("\(DBCol.TABLE_MOBILEAPP) delete row, appId: \(jsonObj["appId"].stringValue) success.")
                    } else {
//                        print("\(DBCol.TABLE_MOBILEAPP) row, appId: \(jsonObj["appId"].stringValue) not found.")
                    }
                } catch {
                    print("\(DBCol.TABLE_MOBILEAPP) delete row, appId: \(jsonObj["appId"].stringValue), failed: \(error).")
                }
            }
        } catch _ {
            print("update \(DBCol.TABLE_MOBILEAPP) table error, \(DBColExpressions.appId)=\(jsonObj["appId"].stringValue).")
        }
    }
    
    
    
    // MARK: - data related function
    func addSearchCache(searchText: String) -> Bool {
        var result = false
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_SEARCH_CACHE)
            let filtering = table.filter(DBColExpressions.searchKeyword == searchText)
            let plucking = try db.pluck(filtering)
            if (plucking == nil) {
                // insert if no previous data
                try db.run(table.insert(DBColExpressions.searchKeyword <- searchText))
                result = true
            }
        } catch _ {
            print("add search cache failed.")
        }
        return result
    }
    
    func getSearchCache() -> NSMutableArray {
        let array = NSMutableArray()
        do {
            let db = try Connection(self.db_pathName)
            let table = Table(DBCol.TABLE_SEARCH_CACHE)
            for items in try db.prepare(table) {
                let data = SearchCache(searchCache: items[DBColExpressions.searchKeyword])
                array.add(data)
            }
        } catch _ {
            print("hahaha search cache fail.")
        }
        return array
    }
    
}
