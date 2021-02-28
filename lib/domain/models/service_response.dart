class ServiceResponse<T> {
  String error;
  T data;

  ServiceResponse({this.error, this.data});
}
