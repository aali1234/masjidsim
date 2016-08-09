require 'date'
require 'pry'

class Stats

	def initialize
		@date=DateTime.now
		@start_year=@date.year
				
		@annual_inflation = 0.01
		@annual_pop_growth = 0.007
		
		@monthly_expenses=Hash.new
		@monthly_expenses[:rent]=350.0
		@monthly_expenses[:utilities]=150.0

		@monthly_income=Hash.new
		@monthly_income[:donation_box]=200.0
		
		@cash_balance = 1000.0
		
		@weekly_attendance=Hash.new
		@weekly_attendance[:jumuah]=30.0
		@weekly_attendance[:adult_halaqa]=10.0
		@weekly_attendance[:sunday_school]=10.0
		
		#Each element represents the percent in that decade of life.
		#So 0..9 years old are 5%, 10..19 are 0%, 20..29 are 0%,
		#	30..39 are 5%, 40..49 are 10%, 50..59 are 20%, etc.
		@age_percents=Array[5.0,0.0,0.0,5.0,10.0,20.0,20.0,20.0,20.0]

		#initially, 90% are male.
		@gender_balance_percent=90.0

		@catastrophes=Hash.new
		@bonuses=Hash.new
		
		@done=false
		
	end

	def recalculate_all
		@monthly_expenses.each do |k,v| v=v*(1+@annual_inflation)/12 end
		@monthly_income.each do |k,v| v=v*(1+@annual_inflation)/12 end
		this_months_expenses = 0
		this_months_income = 0

		@monthly_expenses.each do |k,v| this_months_expenses=this_months_expenses+v end
		@monthly_income.each do |k,v| this_months_income=this_months_income+v end
		
		@cash_balance= @cash_balance+this_months_income-this_months_expenses
		
		@weekly_attendance.each do |k,v| v=v*(1+@annual_pop_growth)/12 end
		@date=@date.next_month
		
		#Each 10 years, move every age_range up a decade
		if 	((@date.year-@start_year)/10>0) &&
			((@date.year-@start_year)%10==0)
			for i in 1..8
				@age_percents[i]=@age_percents[i-1]			
			end
		end
	end

	def display_stats
		puts "Date: 			 #{@date.month} #{@date.year}"
		puts "Monthly Expenses:  #{@monthly_expenses}"
		puts "Monthly Income:    #{@monthly_income}"
		puts "Cash Balance:		 #{@cash_balance}"
		puts "Weekly Attendance: #{@weekly_attendance}"
		puts "Age percents:      #{@age_percents}"
		
	end

	def display_options
		binding.pry
	end


	def done
		if (@date.year-@start_year)>=TIME_LIMIT
			puts "You're out of time! MASJIDSIM FINISHED"
			return true
		end
		if (@cash_balance<-1000)
			puts "Your funds got too low! MASJIDSIM FINISHED"
			return true
		end
		return false
	end
end

	TIME_LIMIT= 50

	stats=Stats.new
	#stats.init_all
	while (!stats.done) do
		stats.recalculate_all
		stats.display_stats
		stats.display_options
	end

