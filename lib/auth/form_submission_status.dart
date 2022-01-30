abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}


class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}


class FormSubmittingAuth extends FormSubmissionStatus{
  const FormSubmittingAuth();
}

class FormSubmittingReg extends FormSubmissionStatus{
  const FormSubmittingReg();
}


class SubmissionSuccess extends FormSubmissionStatus{
  const SubmissionSuccess();
}


class SubmissionFailed extends FormSubmissionStatus{
  const SubmissionFailed();
}



class RegistrationFailed extends FormSubmissionStatus{
  const RegistrationFailed();
}



class LogoutSuccess extends FormSubmissionStatus{
  const LogoutSuccess();
}