class CurrenciesController < ApplicationController

  def first_currency

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_one.html.erb"})
  end

  def second_currency

    @first_symbol = params.fetch("the_symbol")

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_two.html.erb"})

  end


  def exchange

    @first_symbol = params.fetch("the_symbol")
    @convert_to = params.fetch("second_symbol")

    @exchange_raw_data = open("https://api.exchangerate.host/convert?from=#{@first_symbol}&to=#{@convert_to}").read
    @exchange_parsed_data = JSON.parse(@exchange_raw_data)
    @info_data = @exchange_parsed_data.fetch("info")
    @rate = @info_data.fetch("rate")

    render({ :template => "currency_templates/exchange.html.erb"})

  end


end
