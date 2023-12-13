module CsvMailer
  class CsvEmailService

    def perform
      UserMailer.send_email('chmusman1999@gmail.com', 'subject: testing').deliver_later
    end

  end
end