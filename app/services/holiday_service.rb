class HolidayService < ApiService
  def holidays
    get_data('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end
end