class SearchObjectController < ApplicationController
    def search
        rsolr = RSolr.connect :url => 'http://tokaji.tor.c7a.ca:8983/solr/cosearch2'
        @request = rsolr.get 'select', :params => {:q => 'tx:' + params[:q]} 
        puts "test"
        puts @request['response']['docs']
        @results = @request['response']['docs']
        render :json => @results
    end
end
