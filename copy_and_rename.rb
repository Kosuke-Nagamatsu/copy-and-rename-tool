require "fileutils"

numbers = [2, 10, 100, 1000, 2000, 3000]
index = 1

numbers.each do |number|
  Dir.mkdir("data/#{number}") unless Dir.exists?("data/#{number}")
  number.times do
    FileUtils.cp('data/1/aaa_bbb_ccc_ddd.pdf', "data/#{number}/aaa_bbb#{index}_ccc_ddd.pdf")
    index += 1
  end
end