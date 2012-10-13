module Harvest

  # == Fields
  # [+due_at+] when the invoice is due
  # [+due_at_human_format+] when the invoice is due in human representation (e.g., due upon receipt) overrides +due_at+
  # [+client_id+] (REQUIRED) the client id of the invoice
  # [+currency+] the invoice currency
  # [+issued_at+] when the invoice was issued
  # [+subject+] subject line for the invoice
  # [+notes+] notes on the invoice
  # [+number+] invoice number
  # [+kind+] (REQUIRED) the type of the invoice +free_form|project|task|people|detailed+
  # [+projects_to_invoice+] comma separated project ids to gather data from
  # [+import_hours+] import hours from +project|task|people|detailed+ one of +yes|no+
  # [+import_expenses+] import expenses from +project|task|people|detailed+ one of +yes|no+
  # [+period_start+] start of the invoice period
  # [+period_end+] end of the invoice period
  # [+expense_period_start+] start of the invoice expense period
  # [+expense_period_end+] end of the invoice expense period
  # [+csv_line_items+] csv formatted line items for the invoice +kind,description,quantity,unit_price,amount,taxed,taxed2,project_id+
  # [+created_at+] (READONLY) when the invoice was created
  # [+updated_at+] (READONLY) when the invoice was updated
  # [+id+] (READONLY) the id of the invoice
  # [+amount+] (READONLY) the amount of the invoice
  # [+due_amount+] (READONLY) the amount due on the invoice
  # [+created_by_id+] who created the invoice
  # [+purchase_order+] purchase order number/text
  # [+client_key+] unique client key
  # [+state+] (READONLY) state of the invoice
  # [+tax+] applied tax percentage
  # [+tax2+] applied tax 2 percentage
  # [+tax_amount+] amount to tax
  # [+tax_amount2+] amount to tax 2
  # [+discount_amount+] discount amount to apply to invoice
  # [+discount_type+] discount type
  # [+recurring_invoice_id+] the id of the original invoice
  # [+estimate_id+] id of the related estimate
  # [+retainer_id+] id of the related retainer
  class Invoice < Hashie::Mash
    include Harvest::Model

    api_path '/invoices'

    attr_reader :line_items

    def self.parse(json)
      parsed   = String === json ? JSON.parse(json) : json
      invoices = Array.wrap(parsed).map {|attrs| new(attrs["invoices"])}
      invoice  = Array.wrap(parsed).map {|attrs| new(attrs["invoice"])}
      if invoices.first && invoices.first.length > 0
        invoices
      else
        invoice
      end
    end

    def initialize(args = {}, _ = nil)
      if args
        args            = args.to_hash.stringify_keys
        self.line_items = args.delete("csv_line_items")
        self.line_items = args.delete("line_items")
        self.line_items = [] if self.line_items.nil?
      end
      super
    end

    def line_items=(raw_or_rich)
      unless raw_or_rich.nil?
        @line_items = case raw_or_rich
        when String
          @line_items = decode_csv(raw_or_rich).map {|row| Harvest::LineItem.new(row) }
        else
          raw_or_rich
        end
      end
    end

    def as_json(*options)
      json = super(*options)
      json[json_root]["csv_line_items"] = encode_csv(@line_items)
      json
    end

    private
      def decode_csv(string)
        csv = CSV.parse(string)
        headers = csv.shift
        csv.map! {|row| headers.zip(row) }
        csv.map {|row| row.inject({}) {|h, tuple| h.update(tuple[0] => tuple[1]) } }
      end

      def encode_csv(line_items)
        if line_items.empty?
          ""
        else
          header = %w(kind description quantity unit_price amount taxed taxed2 project_id)

          CSV.generate do |csv|
            csv << header
            line_items.each do |item|
              csv << header.inject([]) {|row, attr| row << item[attr] }
            end
          end
        end
      end
  end
end
