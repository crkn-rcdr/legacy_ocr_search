require 'view_component/version'
class LegacyOcrSearchComponent < ViewComponent::Base
    def initialize(documentId:, term:, prefix:)
        @documentId = documentId
        @term = term
        @prefix = prefix
        puts term.length
        if @term.length != 0
            rsolr = RSolr.connect :url => 'http://tokaji.tor.c7a.ca:8983/solr/cosearch2'
            @legacy_ocr_search_request= rsolr.get 'select', :params => {
                :q => 'tx:' + term + ' AND ' + 'pkey:' + @prefix + '.' + @documentId
            } 
            legacy_ocr_search_results_unsorted = []
            for hit in @legacy_ocr_search_request['response']['docs'] do
                stripped=hit['key'].gsub(@prefix+'.'+@documentId+'.', '')
                legacy_ocr_search_results_unsorted.append(stripped.to_i)
            end
            @legacy_ocr_search_results = legacy_ocr_search_results_unsorted.sort
        end
    end
end