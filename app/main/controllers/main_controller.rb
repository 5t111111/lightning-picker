# By default Volt generates this controller for your Main component
class MainController < Volt::ModelController
  def index
    # Add code for when the index view is loaded
    page._results << { display: "boo" }
    page._display_result = false
  end

  def about
    # Add code for when the about view is loaded
  end

  def add_person
    page._persons << { name: page._new_person }
    page._new_person = ''
  end

  def remove_person(person)
    page._persons.delete(person)
  end

  def pick_up
    puts 'INFO: pick_up called.'
    person = page._persons.sample
    puts person._name
    page._persons.delete(person)
    page._picked_persons << { name: person._name }
    page._display_result = true
  end

  def view_history
    puts 'INFO: view_history called.'
    page._picked_persons.each_with_index do |person, i|
      puts "#{i + 1}: #{person._name}"
    end
  end

  def clear_history
    puts 'INFO: clear_history called.'
    answer = `confirm('Are you sure you want to clear history? (This action cannot be undone)');`
    return unless answer
    page._picked_persons.clear
  end

  def hide_result
    puts 'INFO: hide_result called.'
    page._display_result = false
  end

  private

  # The main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
