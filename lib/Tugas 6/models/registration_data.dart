class RegistrationData {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String? major; // Dibuat nullable karena awalnya belum ada yang dipilih
  double semester = 1;
  // Map untuk mengelola status checked dari setiap hobi
  Map<String, bool> hobbies = {
    'Membaca': false,
    'Menulis': false,
    'Bermain Game': false,
    'Olahraga': false,
  };
  bool agreesToTerms = false;
}
