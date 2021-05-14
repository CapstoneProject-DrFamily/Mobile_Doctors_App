class ServiceModel {
  int serviceId;
  double servicePrice;
  String serviceName, serviceDescription;

  ServiceModel({
    this.serviceId,
    this.servicePrice,
    this.serviceName,
    this.serviceDescription,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['id'] as int,
      servicePrice: json['price'] as double,
      serviceName: json['name'] as String,
      serviceDescription: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "servicePrice": servicePrice,
        "serviceName": serviceName,
        "serviceDescription": serviceDescription,
      };
}
