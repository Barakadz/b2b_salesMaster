String formatPhoneNumber(String phone) {
  // Remove all spaces
  phone = phone.replaceAll(' ', '');

  // Remove leading zero if exists
  if (phone.startsWith('0')) {
    phone = phone.substring(1);
  }

  // Append +213 if not already
  if (!phone.startsWith('+213')) {
    phone = '+213$phone';
  }

  return phone;
}
