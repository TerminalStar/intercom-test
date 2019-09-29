module JsonFileReader

  # Reads a file with expected format (see note below), replaces line terminators
  # with commas and transforms into an array, so we can parse file content as JSON.
  #
  # Expects a file formatted with one object per line, and \n as a line terminator.
  # This restriction means the functionality may break for files created on systems
  # with alternate line terminators.
  def read_file(file)
    File
      .read(file)
      .gsub("}\n{", "},{")
      .prepend("[") << "]"
  end
end
