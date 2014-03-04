require("marc")
require_relative("includes")

puts "Usage: main.rb sfx/sirsi infile targets outfile"; exit unless ARGV[0]

def process_sfx_records(infile, targets, solr_xml)
  puts "#new"
  solr_record_set = SolrRecordSet.new(File.open(infile), File.open(targets))
  puts "#to_solr"
  solr_record_set.to_solr(solr_xml)
end

def process_sirsi_records(sirsi_file, sirsi_outfile)
  sirsi_records = SirsiRecords.new(File.open(sirsi_file).read)
  sirsi_records.to_solr(sirsi_outfile)
end

if ARGV[0] == "sfx"
  datafile = ARGV[1]
  targets_file = ARGV[2]
  solr_xml = ARGV[3]
  puts datafile
  puts targets_file
  puts "processing sfx records"
  process_sfx_records(datafile, targets_file, solr_xml)
else
  sirsi_file = ARGV[1]
  sirsi_outfile = ARGV[2]
  process_sirsi_records(sirsi_file, sirsi_outfile)
end
