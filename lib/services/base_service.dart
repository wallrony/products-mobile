abstract class BaseService {
  treatError(dynamic e) {
    String error = e.toString();

    print(error);

    if (error.contains('SocketException')) {
      error =
          'não foi possível conectar ao servidor. Por favor, entre em contato com o suporte.';
    }

    return error;
  }
}
