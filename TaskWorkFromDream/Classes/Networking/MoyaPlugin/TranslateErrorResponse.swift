struct TranslateErrorResponse: Codable {
    let error: TranslateError

    struct TranslateError: Codable {
        public let code: Int
        public let message: String
    }
}
