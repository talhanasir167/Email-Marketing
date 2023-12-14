module CsvMailer
  class CsvEmailService
    require 'csv'

    def perform(params)
      @company_name = params[:company_name]
      @business_email = params[:business_email]
      @csv = params[:csv_file]

      file_path = File.open(@csv)

      CSV.foreach(file_path, headers: true) do |row|
        # debugger.binding

        puts row['Email']
        puts row['Name']
      end
      
      # UserMailer.send_email('chmusman1999@gmail.com', 'subject: testing').deliver_later
    end

  end
end