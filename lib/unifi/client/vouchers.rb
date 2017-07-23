# ./lib/unifi/client/vouchers.rb
module Unifi
  class Client

    module Vouchers

      def create_voucher(options = {})
        body = { cmd: 'create-voucher',
                 expire: options[:expire] ||= 120,
                 n: options[:amount] ||= 1,
                 quota: options[:quota] ||= 1 }
        body[:note] = options[:note] if options[:note]
        body[:up] = options[:up] if options[:up]
        body[:down] = options[:down] if options[:down]
        body[:bytes] = options[:bytes] if options[:bytes]
        response = self.class.post("/s/#{@site}/cmd/hotspot",
                                   { body: body.to_json } )
        response.parsed_response
      end

      def stat_voucher(create_time = nill)
        body = { create_time: create_time }
        response = self.class.get("/s/#{@site}/stat/voucher",
                                   { body: body.to_json })
        response.parsed_response
      end

      def revoke_voucher(voucher_id = nill)
        body = { cmd: 'delete-voucher', _id: voucher_id }
        response = self.class.post("/s/#{@site}/cmd/hotspot",
                                   { body: body.to_json } )
        response.parsed_response
      end

    end

  end
end