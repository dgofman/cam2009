package com.academy.calder.component.validator
{
	import mx.validators.PhoneNumberValidator;

	public class CAMPhoneValidator extends PhoneNumberValidator
	{
		include "CAMValidator.as";
		
		public function CAMPhoneValidator(required:Boolean=false, property:String="text"){
			super();
			this.init(required, property);
			this.invalidCharError = Manager.bundle.getMessage("error_phone_invalidCharError");
			this.wrongLengthError = Manager.bundle.getMessage("error_phone_wrongLengthError");
		}
	}
}