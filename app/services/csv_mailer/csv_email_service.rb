module CsvMailer
  class CsvEmailService

    def perform(options)
      @company_name = options[:company_name]
      @business_email = options[:business_email]
      @csv = options[:csv_file]
      
      # UserMailer.send_email('chmusman1999@gmail.com', 'subject: testing').deliver_later
    end

  end
end