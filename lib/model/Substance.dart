class Substance {
  Substance({
    required this.id,
    required this.formula,
    required this.amount,
    required this.commonName,
    this.airName,
    this.liquidName,
  });
  final int id;
  final String formula;
  final int amount;
  final String commonName;
  final String? airName;
  final String? liquidName;
}
