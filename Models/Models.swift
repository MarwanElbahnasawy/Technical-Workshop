
import Foundation

// MARK: - Root

struct Root: Codable {
    var count: Int?
    var results: [Result]?
}

// MARK: - Result

struct Result: Codable {
    var description: String?
    var name: String?
    var thumbnailURL: String?
    var originalVideoURL: String?
    var sections: [Section]?
    var inspiredByURL: String?
    var instructions: [Instruction]?
    var numServings: Int?
    var thumbnailAltText: String?
    var videoURL: String?
    var id: Int?
    var recipes: [Recipe]?
    enum CodingKeys: String, CodingKey {
        case description
        case name
        case thumbnailURL = "thumbnail_url"
        case originalVideoURL = "original_video_url"
        case sections
        case inspiredByURL = "inspired_by_url"
        case instructions
        case numServings = "num_servings"
        case thumbnailAltText = "thumbnail_alt_text"
        case videoURL = "video_url"
        case id
        case recipes
    }
}

enum ResultAspectRatio: String, Codable {
    case the11 = "1:1"
    case the169 = "16:9"
    case the916 = "9:16"
}

// MARK: - Brand

struct Brand: Codable {
    var name: String?
    var id: Int?
    var slug: String?
    var imageURL: String?
    enum CodingKeys: String, CodingKey {
        case name, id, slug
        case imageURL = "image_url"
        
    }
}



enum Country: String, Codable {
    case gb = "GB"
    case us = "US"
    case zz = "ZZ"
}

enum DraftStatus: String, Codable {
    case published = "published"
}

// MARK: - Instruction

struct Instruction: Codable {
    var temperature: Int?
    var id, position: Int?
    var displayText: String?
    var startTime: Int?
    var appliance: String?
    var endTime: Int?

    enum CodingKeys: String, CodingKey {
        case temperature, id, position
        case displayText = "display_text"
        case startTime = "start_time"
        case appliance
        case endTime = "end_time"
    }
}


// MARK: - Recipe

struct Recipe: Codable {
    var slug: String?
    var createdAt: Int?
    var videoURL: String?
    var approvedAt: Int?
    var brand: String?
    var isShoppable: Bool?
    var totalTimeTier: TotalTimeTier?
    var cookTimeMinutes: Int?
    var keywords: String?
    var recipeID, updatedAt: Int?
    var seoTitle: String?
    var prepTimeMinutes: Int?
    var brandID: String?
    var credits: [Credit]?
    var type: TypeEnum?
    var index: Index?
    var description, thumbnailAltText: String?
    var opType: OpType?
    var canonicalID: String?
    var instructions: [Instruction]?
    var userRatings: UserRatings?
    var servingsNounSingular: String?
    var tags: [Tag]?
    var name: String?
    var draftStatus: DraftStatus?
    var numServings, id: Int?
    var renditions: [Rendition]?
    var topics: [Topic]?
    var yields: String?
    var facebookPosts: [String]?
    var sections: [Section]?
    var aspectRatio: ResultAspectRatio?
    var inspiredByURL: String?
    var isOneTop: Bool?
    var originalVideoURL: String?
    var totalTimeMinutes: Int?
    var showID: Int?
    var thumbnailURL: String?
    var videoAdContent: RecipeVideoAdContent?
    var videoID: Int?

    enum CodingKeys: String, CodingKey {
        case videoURL = "video_url"
        case recipeID = "id"
        case prepTimeMinutes = "prep_time_minutes"
        case type = "_type"
        case index = "_index"
        case description
        case thumbnailAltText = "thumbnail_alt_text"
        case instructions
        case name
        case numServings = "num_servings"
        case id = "_id"
        case sections
        case inspiredByURL = "inspired_by_url"
        case originalVideoURL = "original_video_url"
        case totalTimeMinutes = "total_time_minutes"
        case thumbnailURL = "thumbnail_url"
        case videoID = "video_id"
    }
}

// MARK: - Credit

struct Credit: Codable {
    var name: String?
    
}

enum Index: String, Codable {
    case recipes20230516143201 = "recipes-20230516143201"
}

enum OpType: String, Codable {
    case index = "index"
}

// MARK: - Rendition

struct Rendition: Codable {
    var container: Container?
    var fileSize: Int?
    var url: String?
    var width: Int?
    var minimumBitRate: Int?
    var height: Int?
    var posterURL: String?
    var duration: Int?
    var bitRate: Int?
    var contentType: ContentType?
    var maximumBitRate: Int?

    enum CodingKeys: String, CodingKey {
        case container
        case fileSize = "file_size"
        case url, width
        case minimumBitRate = "minimum_bit_rate"
        case height
        case posterURL = "poster_url"
        case duration
        case bitRate = "bit_rate"
        case contentType = "content_type"
        case maximumBitRate = "maximum_bit_rate"
    }
}

enum Container: String, Codable {
    case mp4 = "mp4"
    case ts = "ts"
}

enum ContentType: String, Codable {
    case applicationVndAppleMpegurl = "application/vnd.apple.mpegurl"
    case videoMp4 = "video/mp4"
}

enum RenditionName: String, Codable {
    case low = "low"
    case mp4180X320 = "mp4_180x320"
    case mp4270X480 = "mp4_270x480"
    case mp4320X320 = "mp4_320x320"
    case mp4404X720 = "mp4_404x720"
    case mp4480X480 = "mp4_480x480"
    case mp4640X640 = "mp4_640x640"
    case mp4720X720 = "mp4_720x720"
}

// MARK: - Section

struct Section: Codable {
    var name: String?
    var position: Int?
}

// MARK: - Component

struct Component: Codable {
    var extraComment: String?
    var ingredient: Ingredient?
    var id, position: Int?
    var measurements: [Measurement]?
    var rawText: String?

    enum CodingKeys: String, CodingKey {
        case extraComment = "extra_comment"
        case ingredient, id, position, measurements
        case rawText = "raw_text"
    }
}

// MARK: - Ingredient

struct Ingredient: Codable {
    var displaySingular: String?
    var updatedAt: Int?
    var name: String?
    var createdAt: Int?
    var displayPlural: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case displaySingular = "display_singular"
        case updatedAt = "updated_at"
        case name
        case createdAt = "created_at"
        case displayPlural = "display_plural"
        case id
    }
}

// MARK: - Measurement

struct Measurement: Codable {
    var unit: Unit?
    var quantity: String?
    var id: Int?
}

// MARK: - Unit

struct Unit: Codable {
    var system: System?
    var name: Abbreviation?
    var displayPlural: DisplayPlural?
    var displaySingular, abbreviation: Abbreviation?

    enum CodingKeys: String, CodingKey {
        case system, name
        case displayPlural = "display_plural"
        case displaySingular = "display_singular"
        case abbreviation
    }
}

enum Abbreviation: String, Codable {
    case ball = "ball"
    case bottle = "bottle"
    case bunch = "bunch"
    case c = "c"
    case can = "can"
    case clove = "clove"
    case cup = "cup"
    case ear = "ear"
    case empty = ""
    case g = "g"
    case gram = "gram"
    case head = "head"
    case jar = "jar"
    case kg = "kg"
    case kilogram = "kilogram"
    case l = "L"
    case largeHandful = "large handful"
    case largeHead = "large head"
    case largeLoaf = "large loaf"
    case largeSprig = "large sprig"
    case lb = "lb"
    case leaf = "leaf"
    case liter = "liter"
    case mL = "mL"
    case milliliter = "milliliter"
    case ounce = "ounce"
    case oz = "oz"
    case package = "package"
    case piece = "piece"
    case pinch = "pinch"
    case pinchOf = "pinch of"
    case pound = "pound"
    case rack = "rack"
    case skewer = "skewer"
    case slice = "slice"
    case sprig = "sprig"
    case stick = "stick"
    case strip = "strip"
    case tablespoon = "tablespoon"
    case tbsp = "tbsp"
    case teaspoon = "teaspoon"
    case toTaste = "to taste"
    case tsp = "tsp"
}

enum DisplayPlural: String, Codable {
    case balls = "balls"
    case bottles = "bottles"
    case bunches = "bunches"
    case cans = "cans"
    case cloves = "cloves"
    case cups = "cups"
    case ears = "ears"
    case empty = ""
    case g = "g"
    case heads = "heads"
    case jars = "jars"
    case kg = "kg"
    case l = "L"
    case largeHandfuls = "large handfuls"
    case largeHeads = "large heads"
    case largeLoaves = "large loaves"
    case largeSprigs = "large sprigs"
    case lb = "lb"
    case leaves = "leaves"
    case mL = "mL"
    case oz = "oz"
    case packages = "packages"
    case pieces = "pieces"
    case pinches = "pinches"
    case pinchesOf = "pinches of"
    case racks = "racks"
    case skewers = "skewers"
    case slices = "slices"
    case sprigs = "sprigs"
    case sticks = "sticks"
    case strips = "strips"
    case tablespoons = "tablespoons"
    case teaspoons = "teaspoons"
    case toTaste = "to taste"
}

enum System: String, Codable {
    case imperial = "imperial"
    case metric = "metric"
    case none = "none"
}

// MARK: - Tag

struct Tag: Codable {
    var rootTagType: RootTagTypeEnum?
    var name: String?
    var id: Int?
    var displayName: String?
    var type: RootTagTypeEnum?

    enum CodingKeys: String, CodingKey {
        case rootTagType = "root_tag_type"
        case name, id
        case displayName = "display_name"
        case type
    }
}

enum RootTagTypeEnum: String, Codable {
    case appliance = "appliance"
    case asian = "asian"
    case businessTags = "business_tags"
    case cookingStyle = "cooking_style"
    case cuisine = "cuisine"
    case dietary = "dietary"
    case difficulty = "difficulty"
    case dinner = "dinner"
    case equipment = "equipment"
    case european = "european"
    case featurePage = "feature_page"
    case healthy = "healthy"
    case holidays = "holidays"
    case meal = "meal"
    case northAmerican = "north_american"
    case occasion = "occasion"
    case seasonal = "seasonal"
}

// MARK: - Topic

struct Topic: Codable {
    var name, slug: String?
}

// MARK: - TotalTimeTier

struct TotalTimeTier: Codable {
    var tier, displayTier: String?

    enum CodingKeys: String, CodingKey {
        case tier
        case displayTier = "display_tier"
    }
}

enum TypeEnum: String, Codable {
    case recipe = "recipe"
}

// MARK: - UserRatings

struct UserRatings: Codable {
    var countPositive: Int?
    var score: Double?
    var countNegative: Int?

    enum CodingKeys: String, CodingKey {
        case countPositive = "count_positive"
        case score
        case countNegative = "count_negative"
    }
}

enum RecipeVideoAdContent: String, Codable {
    case editorialSponsorship = "editorial_sponsorship"
    case none = "none"
    case undetermined = "undetermined"
}

enum ResultVideoAdContent: String, Codable {
    case coBranded = "co_branded"
    case editorialSponsorship = "editorial_sponsorship"
    case none = "none"
}
