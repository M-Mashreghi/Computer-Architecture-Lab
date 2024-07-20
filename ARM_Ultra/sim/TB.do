quit -sim
vlog ../*/*.v
vlog ../*.v
vsim TB
add wave -group IF -position insertpoint sim:/TB/A1/IF1/*
add wave -group ID -position insertpoint sim:/TB/A1/ID1/*
add wave -group EXE -position insertpoint sim:/TB/A1/EX1/*
add wave -group MEM -position insertpoint sim:/TB/A1/SC1/*
add wave -group WB -position insertpoint sim:/TB/A1/WB1/*

add wave -group FW -position insertpoint sim:/TB/A1/FWUnit/*
add wave -group HDU -position insertpoint sim:/TB/A1/HDU/*

add wave -group RegFile -position insertpoint sim:/TB/A1/ID1/RegFile/*
add wave -group RegFile -position insertpoint sim:/TB/A1/ID1/RegFile/regfile

run -all
