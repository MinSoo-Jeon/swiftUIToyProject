//
//  TrackingView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/27.
//

import SwiftUI
import Alamofire

struct BikeRowData: Decodable{
    var rackTotCnt: String
    var stationName: String
    var parkingBikeTotCnt: String
    var shared:String
    var latitude:String
    var longitude:String
    var stationId:String
    
    enum CodingKeys: String, CodingKey{
        case rackTotCnt = "rackTotCnt"
        case stationName = "stationName"
        case parkingBikeTotCnt = "parkingBikeTotCnt"
        case shared = "shared"
        case latitude = "stationLatitude"
        case longitude = "stationLongitude"
        case stationId = "stationId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rackTotCnt = (try? container.decode(String.self, forKey: .rackTotCnt)) ?? ""
        stationName = (try? container.decode(String.self, forKey: .stationName)) ?? ""
        parkingBikeTotCnt = (try? container.decode(String.self, forKey: .parkingBikeTotCnt)) ?? ""
        shared = (try? container.decode(String.self, forKey: .shared)) ?? ""
        latitude = (try? container.decode(String.self, forKey: .latitude)) ?? ""
        longitude = (try? container.decode(String.self, forKey: .longitude)) ?? ""
        stationId = (try? container.decode(String.self, forKey: .stationId)) ?? ""
    }
}

struct BikeDataResult: Decodable{
    var code: String
    var message: String
    
    enum CodingKeys: String, CodingKey{
        case code = "CODE"
        case message = "MESSAGE"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? container.decode(String.self, forKey: .code)) ?? ""
        message = (try? container.decode(String.self, forKey: .message)) ?? ""
    }
}

struct SubData: Decodable{
    var total:Int
    var result:BikeDataResult?
    var row: [BikeRowData]?
    
    enum CodingKeys: String, CodingKey{
        case total = "list_total_count"
        case result = "RESULT"
        case row = "row"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = (try? container.decode(Int.self, forKey: .total)) ?? 0
        result = (try? container.decode(BikeDataResult.self, forKey: .result))
        row = (try? container.decode([BikeRowData].self, forKey: .row))
    }
}

struct EntireData: Decodable{
    var status:SubData?
    
    enum CodingKeys: String, CodingKey{
        case status = "rentBikeStatus"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? container.decode(SubData.self, forKey: .status))
    }
}



struct TrackingView: View {
   
    let mapView = MapView()
    
    func callBikeUrl(_ start: Int) -> Void {
        let bikeAPIURL = "http://openapi.seoul.go.kr:8088/5a484277687a7a6a36346a6f616a61/json/bikeList/\(start)/\(start + 999)/"
        AF.request(bikeAPIURL).responseDecodable(of: EntireData.self) { (response) in
            if let data = response.value{
                if let subData = data.status{
                    if let result = subData.result{
                        if result.code == "INFO-000"{
                            print("success")
                            if let rowData = subData.row{
                                mapView.addAnotationList(rowData)
                            }
                        }else{
                            print("fail")
                        }
                    }
                    if subData.total == 1000 {
                        callBikeUrl(start + 1000)
                    }
                }
            }
        }
    }
    
    var body: some View {
        mapView.onAppear(perform: {
            callBikeUrl(1)
        }).onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
            print("willEnterForeground")
            mapView.removeAllAnnotations()
            callBikeUrl(1)
        })
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}
