import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

enum PaymentMethod {
  creditCard('Credit Card'),
  paypal('Paypal'),
  visaCard('Visa Card'),
  americanExpress('American Express'),
  debitCard('Debit Card'),
  cash('Cash'),
  stripe('Stripe'),
  other('Other');

  const PaymentMethod(this.label);
  final String label;

  static PaymentMethod fromLabel(String value) {
    return PaymentMethod.values.firstWhere(
      (method) => method.label.toLowerCase() == value.toLowerCase(),
      orElse: () => PaymentMethod.other,
    );
  }
}

enum OrderStatus {
  delivered('Delivered'),
  shopping('Shopping'),
  newOrder('New'),
  pending('Pending'),
  cancelled('Cancelled'),
  processing('Processing'),
  other('Other');

  const OrderStatus(this.label);
  final String label;

  static OrderStatus fromLabel(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.label.toLowerCase() == value.toLowerCase(),
      orElse: () => OrderStatus.other,
    );
  }
}

class ProductOrderModal extends IdentifierModel {
  final String orderId;
  final String customerName;
  final String location;
  final PaymentMethod payment;
  final OrderStatus status;
  final int quantity;
  final int price;
  final DateTime orderDate;

  const ProductOrderModal({
    int id = 0,
    this.orderId = '',
    this.customerName = '',
    this.location = '',
    this.payment = PaymentMethod.other,
    this.status = OrderStatus.other,
    this.quantity = 0,
    this.price = 0,
    this.orderDate = const DateTime.fromMillisecondsSinceEpoch(0),
  }) : super(id: id);

  factory ProductOrderModal.fromJson(Map<String, dynamic>? json,
      {int fallbackId = 0}) {
    final data = json ?? <String, dynamic>{};
    return ProductOrderModal(
      id: Model.parseInt(data['id'], defaultValue: fallbackId),
      orderId: Model.parseString(data['order_id']),
      customerName: Model.parseString(data['customer_name']),
      location: Model.parseString(data['location']),
      payment: PaymentMethod.fromLabel(Model.parseString(data['payments'])),
      status: OrderStatus.fromLabel(Model.parseString(data['status'])),
      quantity: Model.parseInt(data['quantity']),
      price: Model.parseInt(data['price']),
      orderDate: Model.parseDateTime(data['order_date']),
    );
  }

  factory ProductOrderModal.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ProductOrderModal.fromJson(decoded);
    }
    return ProductOrderModal.initial();
  }

  static List<ProductOrderModal> listFromJson(List<dynamic>? list) {
    final items = list ?? <dynamic>[];
    return List.generate(
      items.length,
      (index) => ProductOrderModal.fromJson(
        items[index] as Map<String, dynamic>?,
        fallbackId: index + 1,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'customer_name': customerName,
        'location': location,
        'payments': payment.label,
        'status': status.label,
        'quantity': quantity,
        'price': price,
        'order_date': orderDate.toUtc().toIso8601String(),
      };

  ProductOrderModal copyWith({
    int? id,
    String? orderId,
    String? customerName,
    String? location,
    PaymentMethod? payment,
    OrderStatus? status,
    int? quantity,
    int? price,
    DateTime? orderDate,
  }) {
    return ProductOrderModal(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      customerName: customerName ?? this.customerName,
      location: location ?? this.location,
      payment: payment ?? this.payment,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  static ProductOrderModal initial() => const ProductOrderModal();

  static List<ProductOrderModal>? _dummyList;

  static Future<List<ProductOrderModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/product_order.json');
  }
}
