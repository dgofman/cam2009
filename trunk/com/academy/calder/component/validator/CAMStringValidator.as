package com.academy.calder.component.validator
{
	import mx.validators.StringValidator;

	public class CAMStringValidator extends StringValidator
	{
		include "CAMValidator.as";
		
		public function CAMStringValidator(minLength:Number=NaN, maxLength:Number=NaN, 
							required:Boolean=false, property:String="text"){
			super();
			this.init(required, property);
			this.minLength = minLength;
			this.maxLength = maxLength;
			this.tooLongError = Manager.bundle.getMessage("error_str_tooLong");
			this.tooShortError = Manager.bundle.getMessage("error_str_tooShort");
		}
	}
}