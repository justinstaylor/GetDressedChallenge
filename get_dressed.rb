# Created by Justin Taylor. Last edited on 2/28/2020

# frozen_string_literal: false

# From problem description, duplicate articles aren't explicitly disallowed,
# so this allows for multiple hats, shirts, pants, etc. to be worn.
#
# Class handling the input of a space-separated file and verifying and
# outputting order of getting dressed.
class GetDressed
  def self.file_to_arr
    # Prepare file for i/o, read contents, and separate into int array
    file = File.open('clothingList')
    file_data = file.read
    arr = file_data.split(' ').map(&:to_i)
    file.close

    # Handles case where input file is empty
    if !arr.empty?
      check_order(arr)
    else
      int_to_str_arr([7])
    end
  end

  # Handles verification of order of clothes. If clothes are incorrectly put on,
  # code breaks and outputs fail
  def self.check_order(arr)
    used_arr = []
    until arr.empty? # Loops through the array given in the text file
      # Break if fail state (7) or leave state (6) is pushed to queue
      break if used_arr.include?(7) || used_arr.include?(6)

      curr = arr.shift # Implements queue (FIFO structure)
      perform_checks(curr, used_arr)
    end

    int_to_str_arr(used_arr)
  end

  # Checks all the necessary conditions on order of clothing before pushing
  # to final queue
  def self.perform_checks(curr, used_arr)
    if curr == 4
      check_shoes(used_arr)
    elsif curr == 1
      check_hat(used_arr)
    elsif curr == 6
      check_mandatory(used_arr)
    elsif curr < 1 || curr > 6 # If input is out of bounds
      used_arr.push(7)
    else used_arr.push(curr)
    end
  end

  # Verifies that socks and pants are already on before putting shoes on
  # If not, pushes "fail" to the queue and stops checking further items
  def self.check_shoes(used_arr)
    if used_arr.include?(5) && used_arr.include?(2)
      used_arr.push(4)
    else
      used_arr.push(7)
    end
  end

  # Verifies that shirt is on before putting hat on
  # If not, pushes "fail" to the queue and stops checking further items
  def self.check_hat(used_arr)
    if used_arr.include?(3)
      used_arr.push(1)
    else
      used_arr.push(7)
    end
  end

  # Verifies that all necessary articles of clothing are on before leaving
  # If not, pushes "fail" to the queue and stops checking further items
  def self.check_mandatory(used_arr)
    if used_arr.include?(2) && used_arr.include?(3) && used_arr.include?(4) &&
       used_arr.include?(5)
      used_arr.push(6)
    else
      used_arr.push(7)
    end
  end

  # Function to convert numbers to their corresponding article of clothing
  # 7 is used as a fail state
  # Returns a string array of articles of clothing
  def self.int_to_str_arr(arr)
    str_arr = []

    # Hash table mapping numbers to clothes
    clothes = {
      1 => 'hat', 2 => 'pants', 3 => 'shirt',
      4 => 'shoes', 5 => 'socks', 6 => 'leave', 7 => 'fail'
    }

    str_arr.push clothes[arr.shift] until arr.empty?
    arr_to_text(str_arr)
  end

  # Converts string array to text output
  # Outputs to terminal
  def self.arr_to_text(str_arr)
    str_final = ''
    str_final << str_arr.shift + ', ' until str_arr.length == 1
    str_final << str_arr.shift

    puts str_final
  end
end

# Executes the program
GetDressed.file_to_arr
