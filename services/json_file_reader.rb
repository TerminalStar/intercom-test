module JsonFileReader
  def read_file(file)
    File
      .read(file)
      .gsub("}\n{", "},{")
      .prepend("[") << "]"
  end
end
