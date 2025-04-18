abstract class Failure {}

class ServerFailure extends Failure {
  String failure;

  ServerFailure({required this.failure});
}
