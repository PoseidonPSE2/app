class UserContribution {
  final int amountFillings;
  final int amountWater;
  final double savedMoney;
  final double savedTrash;

  UserContribution({
    required this.amountFillings,
    required this.amountWater,
    required this.savedMoney,
    required this.savedTrash,
  });

  factory UserContribution.fromJson(Map<String, dynamic> json) {
    return UserContribution(
      amountFillings: json['amountFillings'] as int,
      amountWater: json['amountWater'] as int,
      savedMoney: (json['savedMoney'] as num).toDouble(),
      savedTrash: (json['savedTrash'] as num).toDouble(),
    );
  }
}
