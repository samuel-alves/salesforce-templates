public with sharing class CalloutUtils {

	private static List<Integer> VALID_STATUS = new List<Integer> { 200, 201, 202, 204 };

	public HttpResponse doRequest (String url, String method, String secretKey, Map< String, String > body)
	{
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(url);
		req.setMethod(method);
		req.setHeader('Authorization', 'Bearer ' + secretKey);
		req.setHeader('Accept', 'application/x-www-form-urlencoded');
		req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		if (body != null)
		{
			req.setBody(urlify(body));
		}
		return h.send(req);
	}

	public static HttpResponse validateResponse(HttpResponse response)
	{
		if (!VALID_STATUS.contains(response.getStatusCode()))
		{
			throw new CalloutException('The service has returned an error');
		}
		return response;
	}

	private static String blankValue(String s1, String s2)
	{
		if (s1 == null || s1 == '') return s2;
		return s1;
	}

	@TestVisible
	private static String urlify(Map<String, String> params)
	{
		String url = '&';
		for (String key : params.keySet()) {
			url += EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(blankValue(params.get(key), ''), 'UTF-8') + '&';
		}
		return url;
	}

	public static String cleanJson(String json)
	{
		json = json.replaceAll('"object":', '"stripeObject":');
		json = json.replaceAll('"date":', '"stripeDate":');
		json = json.replaceAll('"end":', '"endDate":');
		json = json.replaceAll('"data":', '"stripeData":');
		json = json.replaceAll('"currency":', '"stripeCurrency":');
		json = json.replaceAll('"type":', '"stripeType":');

		json = json.replaceAll('"customer":\\s?"cus_', '"customer_id": "cus_');
		json = json.replaceAll('"invoice":\\s?"in_', '"invoice_id": "in_');

		return json;
	}
}