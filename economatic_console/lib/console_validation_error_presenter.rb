require 'terminal-table'

class ConsoleValidationErrorPresenter
  TABLE_STYLE = {
      border_x: "",
      border_y: "",
      border_i: "",
      padding_left: 0,
      padding_right: 2
  }

  def initialize(error)
    @error = error
  end

  def to_s
    [
      color('VALIDATION ERRORS', :bold),
      error_messages_table
    ].join('')
  end

  private

    def error_messages_table
      table = Terminal::Table.new(style: TABLE_STYLE) do |t|
        @error.part_errors.each do |part_name, errors|
          errors.each do |error|
            t << [part_name.to_s + ':', error.description]
          end
        end
      end
    end
end