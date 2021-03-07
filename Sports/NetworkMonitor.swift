//
//  NetworkMonitor.swift
//  Sports
//
//  Created by Kirolos Malak on 3/7/21.
//

import Foundation
import Network

final class NetworkMontior {
    static let shared = NetworkMontior()

    private let queue = DispatchQueue.global()
    private let mointor: NWPathMonitor

    public private(set) var isConnected:Bool = false

    public private(set) var connectionType: ConnectionType = .unknown

    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }

    private init(){
        mointor = NWPathMonitor()
    }

    public func startMonitoring(){
        mointor.start(queue: queue)
        mointor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }

    public func stopMonitoring(){
        mointor.cancel()
    }
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else {
            connectionType = .unknown
        }
    }
}
