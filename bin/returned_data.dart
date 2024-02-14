///
///
///
class ReturnedData {
  final int exitCode;
  final int statusCode;
  final bool canFail;

  ///
  ///
  ///
  ReturnedData({
    required this.exitCode,
    required this.statusCode,
    required this.canFail,
  });

  ///
  ///
  ///
  factory ReturnedData.empty() => ReturnedData(
        exitCode: 0,
        statusCode: 0,
        canFail: true,
      );

  ///
  ///
  ///
  factory ReturnedData.ok({bool canFail = true}) => ReturnedData(
        exitCode: 0,
        statusCode: 200,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.created({bool canFail = true}) => ReturnedData(
        exitCode: 0,
        statusCode: 201,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.accepted({bool canFail = true}) => ReturnedData(
        exitCode: 0,
        statusCode: 202,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.noContent({bool canFail = true}) => ReturnedData(
        exitCode: 0,
        statusCode: 204,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.multipleChoices({bool canFail = true}) => ReturnedData(
        exitCode: 10,
        statusCode: 300,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.badRequest({bool canFail = true}) => ReturnedData(
        exitCode: 110,
        statusCode: 400,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.unauthorized({bool canFail = true}) => ReturnedData(
        exitCode: 111,
        statusCode: 401,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.forbidden({bool canFail = true}) => ReturnedData(
        exitCode: 113,
        statusCode: 403,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.notFound({bool canFail = true}) => ReturnedData(
        exitCode: 114,
        statusCode: 404,
        canFail: canFail,
      );

  ///
  ///
  ///
  factory ReturnedData.serverError({bool canFail = true}) => ReturnedData(
        exitCode: 210,
        statusCode: 500,
        canFail: canFail,
      );

  ///
  ///
  ///
  @override
  int get hashCode {
    int result = 7;
    result = 37 * result + exitCode.hashCode;
    result = 37 * result + statusCode.hashCode;
    result = 37 * result + canFail.hashCode;
    return result;
  }

  ///
  ///
  ///
  @override
  bool operator ==(Object other) {
    if (other is! ReturnedData) {
      return false;
    }

    return (exitCode == other.exitCode) &&
        (statusCode == other.statusCode) &&
        (canFail == other.canFail);
  }

  ///
  ///
  ///
  @override
  String toString() => 'ReturnedData('
      'exitCode: $exitCode, '
      'statusCode: $statusCode, '
      'fail: $canFail)';
}
