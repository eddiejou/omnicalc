class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.length

    @character_count_with_spaces = @text.length

    text_without_spaces = @text.gsub(" ","")
    text_without_linefeed = text_without_spaces.gsub("\n","")
    text_without_cr = text_without_linefeed.gsub("\r","")
    text_without_tabs = text_without_cr.gsub("\t","")

    # or
    # text_without_spaces = @text.gsub(" ","").gsub("\n","").gsub("\r","").gsub("\t","")

    @character_count_without_spaces = text_without_tabs.length

    lower_case_special = @special_word.downcase
    sentence_array = @text.gsub(/[^a-z0-9\s]/i, "")
    lower_case_sentence = sentence_array.downcase
    no_character_array = lower_case_sentence.split
    @occurrences = no_character_array.count(lower_case_special)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    mo_int = @apr/1200
    months = @years*12
    principal = @principal

    @monthly_payment = principal*((mo_int*(1+mo_int)**months)/((1+mo_int)**months-1))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    last = @ending
    first = @starting
    minutes = (last-first)/60
    hours = minutes/60
    days = hours/24
    weeks = days/7
    years = days/365

    @seconds = last-first
    @minutes = minutes
    @hours = hours
    @days = days
    @weeks = weeks
    @years = years

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    min_num = @numbers.min
    max_num = @numbers.max
    sum_num = @numbers.sum
    count_num = @numbers.count
    sorted_num = @numbers.sort
    mean_num = sum_num/count_num
    var_num = [ ]
    entered_numbers = [ ]
    freq = [ ]

    @numbers.each do |element|
      ar = (element-mean_num)**2
      var_num.push(ar)
    end

    variance = (var_num.sum)/count_num

    # @numbers.each do |element|
    #   num_count = @numbers.count(elephant)
    # end


    @numbers.each do |elephant|
      number = elephant
      count = @numbers.count(elephant)
      entered_numbers.push(number)
      freq.push(count)
    end

    mode = entered_numbers[freq.index(freq.max)]

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = min_num

    @maximum = max_num

    @range = max_num-min_num

    @median = (sorted_num[(count_num-1)/2]+sorted_num[(count_num/2)])/2

    @sum = sum_num

    @mean = sum_num/count_num

    @variance = variance

    @standard_deviation = Math.sqrt(variance)

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
