final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

final RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{4,}$");

final RegExp NAME_VALIDATION_REGEX = RegExp(r"^[A-Za-z]+(?:[ '-][A-Za-z]+)*$");
final String PLACEHOLDER_PFP =
    "https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0x0gDQEELoTuER04SsWV.jpg";
