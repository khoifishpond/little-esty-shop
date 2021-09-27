class HolidayFacade
  def self.holidays
    holiday_data = HolidayService.new.holidays
    holidays = holiday_data.map do |data|
      Holiday.new(data)
    end
    holidays.first(3)
  end
end