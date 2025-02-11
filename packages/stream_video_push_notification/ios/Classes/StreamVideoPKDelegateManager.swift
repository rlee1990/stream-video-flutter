import Foundation
import PushKit
import Flutter
import flutter_callkit_incoming

public class StreamVideoPKDelegateManager: NSObject, PKPushRegistryDelegate {
    public static let shared = StreamVideoPKDelegateManager()
    
    private var pushRegistry: PKPushRegistry?
    private var defaultData: [String: Any]?
    private var methodChannel: FlutterMethodChannel?
    
    private override init() {
        super.init()
    }
    
    @objc public func registerForPushNotifications() {
        pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        pushRegistry?.delegate = self
        pushRegistry?.desiredPushTypes = [.voIP]
    }

    public func initChannel(channel: FlutterMethodChannel) {
        methodChannel = channel
    }

    public func initData(data: [String: Any]) {
        defaultData = data
    }
    
    // MARK: - PKPushRegistryDelegate
    @objc public func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let deviceToken = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
        return StreamVideoPushNotificationPlugin.setDevicePushTokenVoIP(deviceToken: deviceToken)
    }
    
    @objc public func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        return StreamVideoPushNotificationPlugin.setDevicePushTokenVoIP(deviceToken: "")
    }
    
    @objc public func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        // Return if type is not voIP.
        guard type == .voIP else {
            return completion()
        }
       
        let defaultCallText = "Unknown Caller"

        // Prepare call kit incoming notification.
        let streamDict = payload.dictionaryPayload["stream"] as? [String: Any]
        let callCid = streamDict?["call_cid"] as? String ?? ""
        var createdByName = streamDict?["created_by_display_name"] as? String
        var createdById = streamDict?["created_by_id"] as? String

        methodChannel?.invokeMethod("customizeCaller", arguments: streamDict) { (response) in
            if let customData = response as? [String: Any] {
                createdByName = customData["name"] as? String ?? createdByName
                createdById = customData["handle"] as? String ?? createdById
            }

            let data: StreamVideoPushParams
            if let jsonData = self.defaultData {
                data = StreamVideoPushParams(args: jsonData)
            } else {
                data = StreamVideoPushParams(args: [String: Any]())
            }

            data.callKitData.uuid = UUID().uuidString
            data.callKitData.nameCaller = createdByName ?? defaultCallText
            data.callKitData.handle = createdById ?? defaultCallText
            data.callKitData.type = 1 //video
            data.callKitData.extra = ["callCid": callCid]

            // Show call incoming notification.
            StreamVideoPushNotificationPlugin.showIncomingCall(
                data: data.callKitData,
                fromPushKit: true
            )
            
            // Complete after a delay to ensure that the incoming call notification
            // is displayed before completing the push notification handling.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                completion()
            }
        }
    }
}
