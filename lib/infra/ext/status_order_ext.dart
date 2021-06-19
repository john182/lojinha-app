import 'package:loja_virtual/model/order.dart';

extension StatusExt on Status {
  String get name {
    switch (this) {
      case Status.canceled:
        return 'Cancelado';
      case Status.pending:
        return 'Pendente';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }
}
