/**
 * @description
 * @author unknown | 2022-12-16
 * @param String[] input
 * @param String search
 * @return Set<String>
 **/
private Set<String> findReferences(String[] input, String search) {
    Set<String> found = new Set<String>{};
    for (String str : input) {
        String ref = findReference(str, search)
            ?.replace('[', '')
            .replace(']', '')
            .replace('ref:', '');
        if (String.isNotBlank(ref)) {
            found.add(ref);
        }
    }
    return found;
}

/**
 * @description
 * @author unknown | 2022-12-16
 * @param String inputString
 * @param String search
 * @return String
 **/
private String findReference(String inputString, String search) {
    Pattern brackets = Pattern.compile(
        '\\[' + //literal left bracket
            '[^\\[]*' + //zero or more of anything other than a left bracket
            search + //the search term, escaped or 'quoted' for regex
            '[^\\]]*' + //zero or more of anything other than a right bracket
            '\\]' //literal right bracket
    );
    Matcher matcher = brackets.matcher(inputString);
    return matcher.find() ? matcher.group(0) : null;
}

Set<String> references = findReferences(
    new List<String>{ 'The reference is [ref: REF00001]\n. Tank you!' },
    'ref:.{1,50}'
);

System.debug('references: ' + references);
