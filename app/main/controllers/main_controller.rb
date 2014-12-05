# coding: utf-8
# By default Volt generates this controller for your Main component
class MainController < Volt::ModelController
  model :store

  def index
    # Add code for when the index view is loaded
    _display_result = false
  end

  def about
    # Add code for when the about view is loaded
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
    return unless person = _persons.sample
    self._spotlight_person = person._name
    _persons.delete(person)
    _picked_persons << person
    self._display_result = true
  end

  def adjust_modal_to_center
    puts 'INFO: pick_up called.'
    window_width = Window.width
    window_height = Window.height
    content_width = `$("#modal-content").outerWidth(true);`
    content_height = `$("#modal-content").outerHeight(true);`
    left_pos = ((window_width - content_width) / 2)
    top_pos = ((window_height - content_height) / 2)
    Element.find('#modal-content').css('left', left_pos.to_s + 'px')
    Element.find('#modal-content').css('top', (top_pos - 200).to_s + 'px')
    nil
  end

  def view_history
    puts 'INFO: view_history called.'
    history_list = ''
    _picked_persons.each_with_index do |person, i|
      history_list += "#{i + 1}: #{person._name}\n"
    end
    alert history_list
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
    self._display_result = false
  end

  private

  # The main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
