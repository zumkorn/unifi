# ./lib/unifi/client/sites.rb
module Unifi
  class Client

    module Sites

      def add_site(description)
        body = { cmd: 'add-site', desc: description }
        response = self.class.post("/s/#{@site}/cmd/sitemgr", { body: body.to_json })
        response.parsed_response
      end


      def delete_site(site_id)
        body = { site: site_id, cmd: 'delete-site' }
        response = self.class.post("/s/#{@site}/cmd/sitemgr", { body: body.to_json })
        response.parsed_response
      end

      def list_sites
        response = self.class.get("/self/sites")
        response.parsed_response
      end

      def stat_sites
        response = self.class.get("/stat/sites")
        response.parsed_response
      end

      def stat_sysinfo
        response = self.class.get("/s/#{@site}/stat/sysinfo")
        response.parsed_response
      end

    end

  end
end