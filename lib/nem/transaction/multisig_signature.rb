module Nem
  module Transaction
    # @attr [String] other_hash
    # @attr [String] other_account
    # @attr [String] signer
    class MultisigSignature < Base
      TYPE = 0x1002 # 4098 (multisig signature transaction)

      attr_reader :other_hash, :other_account, :signer

      def initialize(other_hash, other_account, signer, timestamp: nil, deadline: nil, network: nil)
        @other_hash = other_hash
        @other_account = other_account
        @signer = signer

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::Multisig.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          otherHash: { data: other_hash },
          otherAccount: other_account,
          signer: signer
        }
      end
    end
  end
end
