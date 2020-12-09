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

ops.each_with_index do |op, idx|
  op_code, val = op.split(' ')
  next unless ['jmp', 'nop'].include? op_code
  
  ops_clone = ops.clone
  if op_code == 'jmp'
    ops_clone[idx] = 'nop ' + val
  else
    ops_clone[idx] = 'jmp ' + val
  end

  infinite_loop = false
  $instr_ptr = 0
  $accumulator = 0
  seen_ops.clear
  while !infinite_loop
    if $instr_ptr >= ops_clone.size
      puts $accumulator
      break
    end

    op_engine(ops_clone[$instr_ptr])
    if seen_ops.include? $instr_ptr
      infinite_loop = true
    else
      seen_ops << $instr_ptr
    end
  end
end
