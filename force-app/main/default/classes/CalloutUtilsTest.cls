@isTest
private class CalloutUtilsTest {
	@isTest static void doRequest() {
		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200,'ok','{}',new Map<String, String>()));
		new CalloutUtils().doRequest('api.google.com', 'Post', '123',new Map<String, String>());
	}

	@isTest static void validateResponse() {
		HttpResponse res = new HttpResponse();
		res.setStatus('400');
		String errorMessage;

		try {
			CalloutUtils.validateResponse(res);
		} catch (Exception e) {
			errorMessage = e.getMessage();
		}
		System.assertEquals('The service has returned an error', errorMessage);
	}

	@isTest static void cleanJson() {
		String testString = CalloutUtils.cleanJson('["type":"a"]');
		System.assertEquals('["stripeType":"a"]', testString);
	}
}