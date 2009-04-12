package com.academy.calder.component.validator
{
	import mx.validators.EmailValidator;

	public class CAMEmailValidator extends EmailValidator
	{
		include "CAMValidator.as";
		
		public function CAMEmailValidator(required:Boolean=false, property:String="text"){
			super();
			this.init(required, property);
			this.invalidCharError = Manager.bundle.getMessage("error_mail_invalidCharError");
			this.invalidDomainError = Manager.bundle.getMessage("error_mail_invalidDomainError");
			this.invalidIPDomainError = Manager.bundle.getMessage("error_mail_invalidIPDomainError");
			this.invalidPeriodsInDomainError = Manager.bundle.getMessage("error_mail_invalidPeriodsInDomainError");
			this.missingAtSignError = Manager.bundle.getMessage("error_mail_missingAtSignError");
			this.missingPeriodInDomainError = Manager.bundle.getMessage("error_mail_missingPeriodInDomainError");
			this.missingUsernameError = Manager.bundle.getMessage("error_mail_missingUsernameError");
			this.tooManyAtSignsError = Manager.bundle.getMessage("error_mail_tooManyAtSignsError");
		}
	}
}