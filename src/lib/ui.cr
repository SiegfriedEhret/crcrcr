require "ncurses"

module CRCRCR
  class Ui
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

          s = files[keys[current]]          # current slide
          h, w = NCurses.maxy, NCurses.maxx # max sizes

          lines = s.lines
          line_numbers = lines.size

          lines.each_with_index do |content, i|
            y = ((h - line_numbers) / 2) + i
            x = (w - content.size) / 2

            NCurses.move(x: x, y: y)
            NCurses.addstr(content)
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
