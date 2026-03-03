#!/bin/bash
# Task 1: Basic Functions

function greet(){
  local name=$1
  echo "Hello, $name!"
}

function add(){
  local num1=$1
  local num2=$2
  local sum=$(( num1 + num2 ))
  echo "Sum of two numbers: $sum"
}

greet "Shashank"
add 5 3