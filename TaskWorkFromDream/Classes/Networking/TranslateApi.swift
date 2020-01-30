import Foundation
import Moya

enum TranslateApi {
    
    case hiragana(sentence: String)
}

extension TranslateApi: TargetType {

    var baseURL: URL {
        return URL(string: AppConfigs.Network.appHostUrl)!
    }

    var path: String {
        switch self {
        case .hiragana:
            return "hiragana"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hiragana:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters = [
            "app_id" : appID
        ]

        switch self {
        case .hiragana(let sentence):
            parameters["output_type"] = "hiragana"
            parameters["sentence"] = sentence
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }

    }

    var headers: [String: String]? {
        switch self {
        case .hiragana:
            return ["Content-Type" : "application/json"]
        }
    }

}
