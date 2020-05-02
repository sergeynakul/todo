document.addEventListener('turbolinks:load', function() {
  $('.table').on('click', '.form-inline-link', formInlineLinkHandler)

  var errors = document.querySelector('.resource-errors')
  
  if (errors) {
    var resourceId = errors.dataset.resourceId
    formInlineHandler(resourceId)
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault()
  var todoListId = this.dataset.todoListId
  formInlineHandler(todoListId)
}

function formInlineHandler(todoListId) {
  var link = document.querySelector('.form-inline-link[data-todo-list-id="'  + todoListId + '"]')
  var todoListTitle = document.querySelector('.todo-list-title[data-todo-list-id="'  + todoListId + '"]')
  var formInline = document.querySelector('.form-inline-update[data-todo-list-id="'  + todoListId + '"]')
  
  if (formInline && formInline.classList.contains('hide')) {
    todoListTitle.classList.add('hide')
    formInline.classList.remove('hide')
    link.textContent = 'Cancel'
  } else {
    todoListTitle.classList.remove('hide')
    formInline.classList.add('hide')
    link.textContent = 'Edit'
  }
}
