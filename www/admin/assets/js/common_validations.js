$.validator.addMethod("postalCode", function(value) {
     return value.match(/^[a-zA-Z][0-9][a-zA-Z](-| )?[0-9][a-zA-Z][0-9]$/);
}, 'Please enter a valid postal code');

