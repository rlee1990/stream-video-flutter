//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetCallResponse {
  /// Returns a new [GetCallResponse] instance.
  GetCallResponse({
    this.blockedUsers = const [],
    required this.call,
    required this.duration,
    this.members = const [],
    this.membership,
  });

  List<UserResponse> blockedUsers;

  CallResponse call;

  String duration;

  List<MemberResponse> members;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MemberResponse? membership;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetCallResponse &&
     other.blockedUsers == blockedUsers &&
     other.call == call &&
     other.duration == duration &&
     other.members == members &&
     other.membership == membership;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (blockedUsers.hashCode) +
    (call.hashCode) +
    (duration.hashCode) +
    (members.hashCode) +
    (membership == null ? 0 : membership!.hashCode);

  @override
  String toString() => 'GetCallResponse[blockedUsers=$blockedUsers, call=$call, duration=$duration, members=$members, membership=$membership]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'blocked_users'] = this.blockedUsers;
      json[r'call'] = this.call;
      json[r'duration'] = this.duration;
      json[r'members'] = this.members;
    if (this.membership != null) {
      json[r'membership'] = this.membership;
    } else {
      json[r'membership'] = null;
    }
    return json;
  }

  /// Returns a new [GetCallResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetCallResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetCallResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetCallResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetCallResponse(
        blockedUsers: UserResponse.listFromJson(json[r'blocked_users'])!,
        call: CallResponse.fromJson(json[r'call'])!,
        duration: mapValueOfType<String>(json, r'duration')!,
        members: MemberResponse.listFromJson(json[r'members'])!,
        membership: MemberResponse.fromJson(json[r'membership']),
      );
    }
    return null;
  }

  static List<GetCallResponse>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetCallResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetCallResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetCallResponse> mapFromJson(dynamic json) {
    final map = <String, GetCallResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetCallResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetCallResponse-objects as value to a dart map
  static Map<String, List<GetCallResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetCallResponse>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetCallResponse.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'blocked_users',
    'call',
    'duration',
    'members',
  };
}
