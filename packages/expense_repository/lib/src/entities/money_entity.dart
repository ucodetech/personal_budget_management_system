
class MoneyEntity {
  String moneyId;
  double amount;
  double income;
  String userId;

  MoneyEntity({
       required this.moneyId,
        required this.amount,
        required this.income,
        required this.userId, 
  });

  Map<String, Object?> toDocument() {
     return {
      'moneyId' : moneyId,
      'amount': amount,
      'income' : income,
      'userId': userId
     };
  }

  static MoneyEntity fromDocument(Map<String, dynamic> doc) {
    return MoneyEntity(
      moneyId: doc['moneyId'],
      amount: doc['amount'],
      income: doc['income'],
      userId: doc['userId']
      
    );
  }
}