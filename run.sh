#!/bin/bash

# Initialize Environment

#source /mnt/apps/prebuilt/eda/cadence-2019-20.bash

ls ./hdl/*.v | xargs -n 1 basename > hdl.list.tmp

mkdir ./exports
rm -rf ./exports/*

mkdir ./reports
rm -rf ./reports/*

mkdir ./tmp
rm -rf ./tmp/*

genus -f ./runtime/genus_exec.tcl

rm -rf ./**.tmp
rm -rf ./exports/*
rm -rf ./tmp/*
