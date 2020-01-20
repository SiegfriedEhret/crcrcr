require "ncurses"

module CRCRCR
  class Line
    getter text : String
    getter x : Float64 | Int32

    def initialize(@text, @x)
    end
  end

  class Ui
    def self.get_lines_and_positions(content : String, w : Int32)
      lines = content.lines
      line_numbers = lines.size

      result = [] of Line

      lines.each_with_index do |line, i|
        x = i == 0 ? ((w - line.size) / 2) : 0
        if x < 0
          x = 0
        end

        if (line.size < w)
          result << Line.new(line, x)
        else
          content
            .scan(/.{1,#{w}}/)
            .map { |c| c[0].strip }
            .each { |chunk| result << Line.new(chunk, x) }
        end
      end

      result
    end

    def self.run(files : Hash(String, String))
      keys = files.keys.sort
      current = 0

      NCurses.open do
        NCurses.cbreak
        NCurses.noecho
        NCurses.keypad(true)
        NCurses.notimeout(true)

        loop do
          NCurses.erase

          s = files[keys[current]]
          lines = self.get_lines_and_positions(s, NCurses.maxx)
          y = ((NCurses.maxy - lines.size) / 2)
          if y < 0
            y = 0
          end

          lines.each do |line|
            NCurses.mvaddstr(line.text, x: line.x, y: y)
            y += 1
          end

          NCurses.refresh

          key = NCurses.getch
          case key
          when 'q', NCurses::KeyCode::ESC
            break
          when NCurses::KeyCode::LEFT
            current -= 1
          when NCurses::KeyCode::RIGHT
            current += 1
          end

          if current < 0
            current = 0
          end

          if current > files.size - 1
            break
          end
        end
      end
    end
  end
end
