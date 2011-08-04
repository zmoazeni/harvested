module Harvest
  class Invoice < Hashie::Dash
    include Harvest::Model

    api_path '/invoices'
    
    api_path '/invoices'
    
    attr_reader :line_items
    
    property :id
    property :subject
    property :number
    property :created_at
    property :updated_at
    property :issued_at
    property :due_at
    property :due_at_human_format
    property :due_amount
    property :notes
    property :recurring_invoice_id
    property :period_start
    property :period_end
    property :discount
    property :discount_amount
    property :client_key
    property :amount
    property :tax
    property :tax2
    property :tax_amount
    property :tax2_amount
    property :csv_line_items
    property :client_id
    property :estimate_id
    property :purchase_order
    property :retainer_id
    property :currency
    property :state
    property :kind
    property :import_hours
    property :import_expenses
    
    def self.json_root; "doc"; end
    # skip_json_root true
    
    def initialize(args = {})
      @line_items = []
      args            = args.stringify_keys
      self.line_items = args.delete("csv_line_items")
      self.line_items = args.delete("line_items")
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
          
          # writing this in stdlib so we don't force 1.8 users to install FasterCSV and make gem dependencies wierd
          if RUBY_VERSION =~ /1.8/
            csv_data = ""
            CSV.generate_row(header, header.size, csv_data)
            line_items.each do |item|
              row_data = header.inject([]) {|row, attr| row << item[attr] } 
              CSV.generate_row(row_data, row_data.size, csv_data)
            end
            csv_data
          else
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
end