#!/usr/bin/env ruby

def nop
end

def acc(amt)
  $accumulator += amt
end

def jmp(amt)
  $instr_ptr += amt
end

def op_engine(op_code)
  op_code, amt = op_code.split(' ')
  amt = amt.to_i

  case op_code
  when 'nop'
    $instr_ptr += 1
  when 'acc'
    acc(amt)
    $instr_ptr += 1
  when 'jmp'
    jmp(amt)
  end
end

ops = []
seen_ops = []
$accumulator = 0
$instr_ptr = 0
file = IO.foreach("prob1.txt") { |line|
  ops << line
}

while true
  op_engine(ops[$instr_ptr])

  if seen_ops.include? $instr_ptr
    puts $accumulator 
    break
  end

  seen_ops << $instr_ptr
end
