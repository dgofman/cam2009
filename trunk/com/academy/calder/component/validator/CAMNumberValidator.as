package com.academy.calder.component.validator
{
	import mx.validators.NumberValidator;

	public class CAMNumberValidator extends NumberValidator
	{
		include "CAMValidator.as";
		
		public function CAMNumberValidator(precision:uint=2, allowNegative:Boolean=false, 
						decimalSeparator:String=".", required:Boolean=false, property:String="text"){
			super();
			this.init(required, property);
			this.precision = precision;
			this.allowNegative = allowNegative;
			this.decimalSeparator = decimalSeparator;
			this.decimalPointCountError = Manager.bundle.getMessage("error_num_decimalPointCount");
			this.exceedsMaxError = Manager.bundle.getMessage("error_num_exceedsMax");
			this.integerError = Manager.bundle.getMessage("error_num_integer");
			this.invalidCharError = Manager.bundle.getMessage("error_num_invalidChar");
			this.invalidFormatCharsError = Manager.bundle.getMessage("error_num_invalidFormatChars");
			this.lowerThanMinError = Manager.bundle.getMessage("error_num_lowerThanMin");
			this.negativeError = Manager.bundle.getMessage("error_num_negative");
			this.precisionError = Manager.bundle.getMessage("error_num_precision");
			this.separationError = Manager.bundle.getMessage("error_num_separation");
		}
	}
}