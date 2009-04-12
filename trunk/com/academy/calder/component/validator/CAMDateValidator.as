package com.academy.calder.component.validator
{
	import mx.validators.DateValidator;

	public class CAMDateValidator extends DateValidator
	{
		include "CAMValidator.as";
		
		public function CAMDateValidator(inputFormat:String="MM/DD/YYYY", required:Boolean=false, property:String="text"){
			super();
			this.init(required, property);
			this.inputFormat = inputFormat;
			this.formatError = Manager.bundle.getMessage("error_day_formatError");
			this.invalidCharError = Manager.bundle.getMessage("error_day_invalidCharError");
			this.wrongDayError = Manager.bundle.getMessage("error_day_wrongDayError");
			this.wrongLengthError = Manager.bundle.getMessage("error_day_wrongLengthError"); 
			this.wrongMonthError = Manager.bundle.getMessage("error_day_wrongMonthError");
			this.wrongYearError = Manager.bundle.getMessage("error_day_wrongYearError");
		}
	}
}