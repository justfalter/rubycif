require 'rake/clean'

PROTO_LIBS_PATH = File.expand_path('lib/rubycif/protocols')

def gen_proto(module_name, sources)
  dst_proto_file = "#{module_name.downcase}.proto"
  sources.map! {|f| File.expand_path(f)}
  cd PROTO_LIBS_PATH do
    File.open(dst_proto_file, "w")  do |fio|
      fio.puts("package RubyCif.Protocols.#{module_name};")
      sources.each do |src_filename|
        fio.puts(File.read(src_filename))
      end 
    end

    sh "protoc --ruby_out=. #{dst_proto_file}"
  end 
end 

task :gen_protos do
  cd PROTO_LIBS_PATH do
    FileList["*.proto"].each do |filename|
      sh "protoc --ruby_out=. #{filename}"
    end 
  end 
end

task :default => :gen_protos

CLEAN.include(FileList["#{PROTO_LIBS_PATH}/*.pb.rb"])
#CLEAN.include(FileList["#{PROTO_LIBS_PATH}/*.proto"])
