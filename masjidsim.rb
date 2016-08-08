init_all
while (!done) do
	recalculate_all
	display_stats
	display_options
	done=at_end_state?
end

def init_all
	d=DateTime.now
	year=d.year
	month=d.month
	
	annual_inflation = 0.01
	annual_pop_growth = 0.007
	
	monthly_expenses=Hash.new
	monthly_expenses[:rent]=350.0
	monthly_expenses[:utilities]=150.0

	monthly_income=Hash.new
	monthly_income[:donation_box]=200.0
	
	weekly_attendance=Hash.new
	weekly_attendance[:jumuah]=30.0
	weekly_attendance[:adult_halaqa]=10.0
	weekly_attendance[:sunday_school]=10.0
	
	
	#demographics percentages
	demog=Hash.new
	demog[:0_9]=5.0
	demog[:10_19]=0.0
	demog[:20_29]=0.0
	demog[:30_39]=5.0
	demog[:40_49]=10.0
	demog[:50_59]=20.0
	demog[:60_69]=20.0
	demog[:70_79]=20.0
	demog[:80_89]=20.0
	demog[:men_vs_women]=90.0

	done=false
	
end

def display_stats
	puts "Date: 			 #{month} #{year}"
	puts "Monthly Expenses:  #{monthly_expenses}"
	puts "Monthly Income:    #{monthly_income}"
	puts "Weekly Attendance: #{weekly_attendance}"
	puts "Demographics:      #{demog}"
	
end

def display_options
	binding.pry
end

def recalculate_all
	foreach e in monthly_expenses do e=e*(1+annual_inflation)/12 end
	foreach i in monthly_income do i=i*(1+annual_inflation)/12 end
	foreach a in weekly_attendance do a=a*(1+annual_pop_growth)/12 end
	
end

def at_end_state?
	false
end