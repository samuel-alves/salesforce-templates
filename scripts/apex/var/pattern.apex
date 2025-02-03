String testRegex(String search) {
//    String search = Pattern.quote('ref:.{1,50}');
    String subject = 'The reference is [ref: REF00001]. Tank you!';
    Pattern brackets = Pattern.compile(
        '\\[' + //literal left bracket
            '[^\\[]*' + //zero or more of anything other than a left bracket
            search + //the search term, escaped or 'quoted' for regex
            '[^\\]]*' + //zero or more of anything other than a right bracket
            '\\]' //literal right bracket
    );
    Matcher matcher = brackets.matcher(subject);
    System.assert(matcher.find());
    System.assertEquals('[ref: REF00001]', matcher.group(0));
    return matcher.group(0);
}
String reference = testRegex('ref:.{1,50}').replace('[ref:', '').replace(']', '').trim();
System.debug(reference);