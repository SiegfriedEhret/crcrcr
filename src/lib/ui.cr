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

          s = files[keys[current]]
          h, w = NCurses.maxy, NCurses.maxx
          y = h / 2
          x = (w - s.size) / 2

          NCurses.addstr(s)
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
