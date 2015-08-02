# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController

    model :store

    # A local reactive variable to store the editing state
    reactive_accessor :display_result
    reactive_accessor :display_history
    reactive_accessor :history_button_text

    def index
      # Add code for when the index view is loaded
      self.display_result = false
      self.display_history = false
      self.history_button_text = 'Show history'
    end

    def add_person
      puts 'INFO: add_person called.'
      _persons << { name: _new_person }
      self._new_person = ''
    end

    def remove_person(person)
      puts 'INFO: remove_person called.'
      _persons.delete(person)
    end

    def pick_up
      puts 'INFO: pick_up called.'
      return if _persons.size == 0
      return if display_result == true
      person = _persons.sample
      self._spotlight_person = person._name
      _persons.delete(person)
      _picked_persons << person
      self.display_result = true
    end

    def adjust_modal_to_center
      # TODO: Remove jQuery DOM manipulation
      puts 'INFO: adjust_modal_to_center called.'
      window_width = `$(window).width()`
      window_height = `$(window).height()`
      content_width = `$("#modal-content").outerWidth(true);`
      content_height = `$("#modal-content").outerHeight(true);`
      left_pos = ((window_width - content_width) / 2)
      top_pos = ((window_height - content_height) / 2)
      `$('#modal-content').css('left', left_pos + 'px')`
      `$('#modal-content').css('top', (top_pos - (window_height / 6)) + 'px')`
      nil
    end

    def toggle_history
      puts 'INFO: toggle_history called.'
      if self.display_history
        self.display_history = false
        self.history_button_text = 'Show history'
      else
        self.display_history = true
        self.history_button_text = 'Hide history'
      end
    end

    def clear_history
      puts 'INFO: clear_history called.'
      answer = `confirm('Are you sure you want to clear history? (This action cannot be undone)');`
      return unless answer
      # workaround for some items remain after delete
      while _picked_persons.size != 0
        _picked_persons.each do |person|
          _picked_persons.delete(person) if person
        end
      end
    end

    def hide_result
      puts 'INFO: hide_result called.'
      self.display_result = false
    end

    def about
      # Add code for when the about view is loaded
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
