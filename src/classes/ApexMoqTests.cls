@IsTest
private class ApexMoqTests {

    @IsTest
    static void it_should_capture_the_correct_number_of_invocations_with_no_parameters() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesNothing();
        sut.takesNothing();
        sut.takesNothing();
        
        sut.verify('takesNothing', Times.Exactly(3));
    }
    
    @IsTest
    static void it_should_capture_the_correct_number_of_invocations_with_string_parameter() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesString('someArgument');
        sut.takesString('someArgument');
        sut.takesString('someArgument');
        sut.takesString('someOtherArgument');
        
        sut.verify('takesString', new List<Object>{'someArgument'}, Times.Exactly(3));
    	sut.verify('takesString', new List<Object>{'someOtherArgument'}, Times.Exactly(1));
    }

    @IsTest
    static void it_should_verify_the_correct_number_of_invocations_using_the_times_class_static_properties() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesString('default');

        sut.takesString('1');

        sut.takesString('2');
        sut.takesString('2');

        sut.takesString('3');
        sut.takesString('3');
        sut.takesString('3');
        
        sut.takesString('AtLeastOnce');
        
        sut.takesString('AtLeastFourTimes');
        sut.takesString('AtLeastFourTimes');
        sut.takesString('AtLeastFourTimes');
        sut.takesString('AtLeastFourTimes');
        
        sut.verify('takesString', new List<Object>{'default'});
        sut.verify('takesString', new List<Object>{'1'}, Times.Once);
    	sut.verify('takesString', new List<Object>{'2'}, Times.Twice);
    	sut.verify('takesString', new List<Object>{'3'}, Times.Thrice);
    	sut.verify('takesString', new List<Object>{'never'}, Times.Never);
    	sut.verify('takesString', new List<Object>{'AtLeastOnce'}, Times.AtLeastOnce);
    	sut.verify('takesString', new List<Object>{'AtLeastFourTimes'}, Times.AtLeast(4));
    }

    @IsTest
    static void it_should_return_the_known_value_when_null_is_given() {
        DerivedMock sut = new DerivedMock();
        String knownValue = 'x';
        String alsoKnownValue = 'y';

        sut.setup('takesString', new List<Object>{''}).returns(alsoKnownValue);
        sut.setup('takesString', new List<Object>{null}).returns(knownValue);

        String results = sut.takesString(null);

        System.assertEquals(knownValue, results);
    }

    @IsTest
    static void it_should_return_the_known_value_when_a_blank_string_is_given() {
        DerivedMock sut = new DerivedMock();
        String knownValue = 'x';
        String alsoKnownValue = 'y';

        sut.setup('takesString', new List<Object>{''}).returns(alsoKnownValue);
        sut.setup('takesString', new List<Object>{null}).returns(knownValue);

        String results = sut.takesString('');

        System.assertEquals(alsoKnownValue, results);
    }

    @IsTest
    static void it_should_return_the_known_value_when_an_uppercase_string_is_given() {
        DerivedMock sut = new DerivedMock();
        String knownValue = 'x';
        String alsoKnownValue = 'y';

        sut.setup('takesString', new List<Object>{'caseSensitive'}).returns(alsoKnownValue);
        sut.setup('takesString', new List<Object>{'CASE_SENSITIVE'}).returns(knownValue);

        String results = sut.takesString('CASE_SENSITIVE');

        System.assertEquals(knownValue, results);
    }

    @IsTest
    static void it_should_return_the_known_value_when_a_lowercase_string_is_given() {
        DerivedMock sut = new DerivedMock();
        String knownValue = 'x';
        String alsoKnownValue = 'y';

        sut.setup('takesString', new List<Object>{'caseSensitive'}).returns(knownValue);
        sut.setup('takesString', new List<Object>{'CASE_SENSITIVE'}).returns(alsoKnownValue);

        String results = sut.takesString('caseSensitive');

        System.assertEquals(knownValue, results);
    }
    
    @IsTest
    static void it_should_capture_the_correct_number_of_invocations_for_numbers() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesInteger(1);
        sut.takesInteger(1);
        sut.takesInteger(1);
        sut.takesInteger(2);
        
        sut.verify('takesInteger', new List<Object>{1}, Times.Exactly(3));
    }
    
    @IsTest
    static void it_should_capture_the_correct_number_of_invocations_for_non_primitives() {
        DerivedMock sut = new DerivedMock();
        NonPrimitive np1 = new NonPrimitive();
        np1.strMember = 'np1';
        np1.intMember = 1;
        np1.dblMember = 1.11;
        NonPrimitive np2 = new NonPrimitive();
        np1.strMember = 'np2';
        np1.intMember = 2;
        np1.dblMember = 2.22;

        sut.takesNonPrimitive(np1);
        sut.takesNonPrimitive(np1);
        sut.takesNonPrimitive(np1);
        sut.takesNonPrimitive(np2);
        
        sut.verify('takesNonPrimitive', new List<Object>{np1}, Times.AtLeastOnce);
        sut.verify('takesNonPrimitive', new List<Object>{np1}, Times.AtLeast(2));
        sut.verify('takesNonPrimitive', new List<Object>{np1}, Times.AtLeast(3));
        sut.verify('takesNonPrimitive', new List<Object>{np1}, Times.Exactly(3));
        sut.verify('takesNonPrimitive', new List<Object>{np2}, Times.Once);
    }

    @IsTest
    static void it_should_assert_the_correct_number_of_invocations_with_string_parameter() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesString('someArgument');
        sut.takesString('someArgument');
        sut.takesString('someArgument');
        sut.takesString('someOtherArgument');
        
        sut.verify('takesString', new List<Object>{'someArgument'}, Times.AtLeastOnce);
        sut.verify('takesString', new List<Object>{'someArgument'}, Times.Thrice);
        sut.verify('takesString', new List<Object>{'someOtherArgument'}, Times.Once);
        sut.verify('takesString', new List<Object>{'abcdefg'}, Times.Never);
    }
    
    @IsTest
    static void it_should_return_the_default_call() {
        DerivedMock sut = new DerivedMock();
        sut.setup('takesString',ApexMoq.Arguments.HAVE_ANY_VALUE).returns('abc');
        
        String returnValue = sut.takesString('123');
        
        System.assertEquals('abc', returnValue);
    }

    @IsTest
    static void it_should_verify_the_call_was_made_with_any_arguments() {
        DerivedMock sut = new DerivedMock();
        
        sut.takesString('123');
        
        sut.verify('takesString', ApexMoq.ARGUMENTS_HAVE_ANY_VALUE, Times.Once);
    }
    
    @IsTest
    static void it_should_return_the_setup_call_instead_of_the_default_one() {
        DerivedMock sut = new DerivedMock();
        sut.setup('takesString',ApexMoq.Arguments.HAVE_ANY_VALUE).returns('abc');
        sut.setup('takesString',new List<Object> {'123'}).returns('xyz');        

        String returnValue = sut.takesString('123');
        
        System.assertEquals('xyz', returnValue);
    }
    
    @IsTest
    static void it_should_return_null_when_no_setup_was_performed() {
        DerivedMock sut = new DerivedMock(); 
        
        String returnValue = sut.takesString('123');
        
        System.assertEquals(null, returnValue);
    }
    
    @IsTest
    static void it_should_throw_the_setup_exception() {
        DerivedMock sut = new DerivedMock();
        sut.setup('takesString',new List<Object> {'123'}).throws(new TestException('test exception msg'));        

        try{
            String returnValue = sut.takesString('123');
            System.assert(false);
        }catch(Exception ex) {
            System.assertEquals('test exception msg', ex.getMessage());
        }
    }

    @IsTest
    static void it_should_throw_the_setup_exception_with_have_any_parameters_argument() {
        DerivedMock sut = new DerivedMock();
        sut.setup('takesString',ApexMoq.ARGUMENTS_HAVE_ANY_VALUE).throws(new TestException('test exception msg'));        

        try{
            String returnValue = sut.takesString('123');
            System.assert(false);
        }catch(Exception ex) {
            System.assertEquals('test exception msg', ex.getMessage());
        }
    }

    @IsTest
    static void it_should_verify_when_the_previously_passed_argument_is_changed() {
        NonPrimitive changingObject = new NonPrimitive();
        changingObject.strMember = '1';

        DerivedMock sut = new DerivedMock();

        sut.setup('takesNonPrimitive',new List<Object>{changingObject}).returns('');

        sut.takesString(string.valueOf(changingObject));
        changingObject.strMember = '2';
        sut.takesString(string.valueOf(changingObject));

        sut.verify('takesString', new List<Object>{string.valueOf(changingObject)}, Times.Once);
    }
    
    @IsTest
    static void it_should_return_different_values_when_setup_sequence_is_called() {
        DerivedMock sut = new DerivedMock();
        sut.setupSequence('takesNothing')
            .returns('abc')
            .returns('def')
            .returns('ghi');
        
        String returnValue1 = sut.takesNothing();
        String returnValue2 = sut.takesNothing();
        String returnValue3 = sut.takesNothing();
        
        System.assertEquals('abc', returnValue1);
        System.assertEquals('def', returnValue2);
        System.assertEquals('ghi', returnValue3);
    }
    
    @IsTest
    static void it_should_return_different_values_when_setup_sequence_is_called_with_any_args_option() {
        DerivedMock sut = new DerivedMock();
        sut.setupSequence('takesInteger', ApexMoq.ARGUMENTS_HAVE_ANY_VALUE)
            .returns('one')
            .returns('two')
            .returns('three');
        
        String returnValue1 = sut.takesInteger(1);
        String returnValue2 = sut.takesInteger(1);
        String returnValue3 = sut.takesInteger(2);
        
        System.assertEquals('one', returnValue1);
        System.assertEquals('two', returnValue2);
        System.assertEquals('three', returnValue3);
    }

    @IsTest
    static void it_should_use_the_private_hashcode_property_to_differentiate_instances_of_apexMoq() {
        DerivedMock sut1 = new DerivedMock();
        DerivedMock sut2 = new DerivedMock();

        System.assertNotEquals(String.valueOf(sut1), String.valueOf(sut2));
    }

    //TODO: Is this possible to implement?
    //@IsTest
    static void it_should_return_the_same_object_even_when_changed_between_invocations() {
        
        //NonPrimitive changingObject = new NonPrimitive();
        //changingObject.strMember = '1';

        //DerivedMock sut = new DerivedMock();

        //sut.setup('takesStringReturnsNonPrimitive',new List<Object>{'1'}).returns(changingObject);
        //sut.setup('takesStringReturnsNonPrimitive',new List<Object>{'2'}).returns(changingObject);

        //String stringify1 = String.valueOf(sut.takesStringReturnsNonPrimitive('1'));
        //changingObject.strMember = '2';
        //String stringify2 = String.valueOf(sut.takesStringReturnsNonPrimitive('2'));

        //System.assertEquals(stringify1, stringify2);
    }    
 
    //////////////////////////////////////////////////////////////////////////////
    
    private class DerivedMock extends ApexMoq {
        public String takesString(String someArgument) {
            return (String)handleMethodInvocation('takesString', new List<Object>{someArgument});
        }
        
        public String takesInteger(Integer someArgument) {
            return (String)handleMethodInvocation('takesInteger', new List<Object>{someArgument});
        }
        
        public String takesNonPrimitive(NonPrimitive someArgument) {
            return (String)handleMethodInvocation('takesNonPrimitive', new List<Object>{someArgument});
        }
        
        public String takesNothing() {
            return (String)handleMethodInvocation('takesNothing');
        }

        public NonPrimitive takesStringReturnsNonPrimitive(String someArgument) {
            return (NonPrimitive)handleMethodInvocation('takesStringReturnsNonPrimitive', new List<Object>{someArgument});
        }
    }
    
    private class NonPrimitive {
        public String strMember;
        public Integer intMember;
        public Double dblMember;
    }
    
    private class TestException extends Exception {}
}