mixin MobileValidation {
  mobileValadition(value) {
    if (value == null || value.isEmpty) {
      return "Mobile-Number Required";
    } else if (!RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$')
        .hasMatch(value)) {
      return "Invalid Mobile-Number";
    } else {
      return null;
    }
  }

  MpinValidator(value) {
    if (value == null || value.isEmpty) {
      return "MPin Required";
    } else if (value.length != 4) {
      return "MPin length must be 4";
    } else {
      return null;
    }
  }

  MpinConfirmer(value, Mpin) {
    if (value != Mpin.toString()) {
      return "MPin doesn't match";
    } else {
      return null;
    }
  }
}
