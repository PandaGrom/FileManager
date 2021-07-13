class FileManager

  EXTENSIONS = %w[txt rb js docx doc css html]
  INVALID_SYMBOLS = %W[/ \\ * " | : < >]

  attr_accessor \
    :name,
    :extension,
    :operation,
    :text

  def initialize(name:, extension:, operation:, text: nil)
    @name = name
    @extension = extension
    @operation = operation
    @text = text
  end

  def call
    validation

    operations
  end

  private

  def validation
    validate_existion
    validate_correct_ext
    validate_correct_name
  end

  def validate_correct_name
    INVALID_SYMBOLS.each do |symbol|
      raise 'Incorrect name' if name.include? symbol
    end
  end

  def validate_existion
    raise 'file didn\'t found' if !File.exist?(filename) && operation != 'create'
  end

  def validate_correct_ext
    raise 'Incorrect extension' unless EXTENSIONS.include? extension
  end
  
  def filename
    "#{name}.#{extension}"
  end

  def operations
    case operation
      when 'read'; read
      when 'add'; add
      when 'create'; create
      when 'destroy'; destroy
    end
  end
  
  def read
    File.open(filename, 'r') do |file|
       file.read()
    end
  end
    
  def add
    File.open(filename, 'a') do |file|
       file.write(text)
    end
  end
  
  def create
    File.open(filename, 'w') do |file|
       file.write(text)
    end
  end

  def destroy
    File.delete(filename) do |file|
    end
  end

end

p FileManager.new(name: 'text', extension: 'txt', operation: 'create', text: 'something').call