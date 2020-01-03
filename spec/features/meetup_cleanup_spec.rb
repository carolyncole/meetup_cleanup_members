require 'byebug'

describe "the signin process", type: :feature, js: true do

  def slow_typing(element, text)
    text.each_char do |character| 
       element.send_keys(character)
       sleep(0.3)
    end
  end
  it "signs me in" do
    visit "https://secure.meetup.com/login"
    fill_in 'email', with: ENV['EMAIL']
    pass_word_field = find("#password")
    slow_typing(pass_word_field, ENV['PASSWORD'])
    click_button 'loginFormSubmit'

    File.open('ids.txt').each do |id|
      puts id
      email_blurb = "To keep the Women's Adventure Club of Centre County affordable (Meet-Up charges based on # of members), we are reviewing our membership list and eliminating those members who have not visited the site in over a year. Please feel free to rejoin WAC if/when you have time to actively participate. Thank you and best wishes for a healthy and happy new year!"
      url = "https://www.meetup.com/Womens-Adventure-Club-of-Centre-County/members/remove/?id=#{id}&emailBlurb=#{URI::encode(email_blurb)}&returnUri=https%3A%2F%2Fwww.meetup.com%2FWomens-Adventure-Club-of-Centre-County%2Fmembers%2F"
      visit url
      click_button 'Remove member'
      sleep(10)
    end
  end
end