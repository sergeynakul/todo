document.addEventListener('turbolinks:load', function() {
  $('.tasks').on('click', '.form-inline-link', formInlineLinkTaskHandler)

  var errors = document.querySelector('.resource-errors')
  
  if (errors) {
    var resourceId = errors.dataset.resourceId
    formInlineTaskHandler(resourceId)
  }
})

function formInlineLinkTaskHandler(event) {
  event.preventDefault()
  var taskId = this.dataset.taskId
  formInlineTaskHandler(taskId)
}

function formInlineTaskHandler(taskId) {
  var link = document.querySelector('.form-inline-link[data-task-id="'  + taskId + '"]')
  var taskInner = document.querySelector('.task_inner[data-task-id="'  + taskId + '"]')
  var formInline = document.querySelector('.form-inline-update[data-task-id="'  + taskId + '"]')
  var resourceErrors = document.querySelector('.resource-errors[data-resource-id="'  + taskId + '"]')
  
  if (formInline && formInline.classList.contains('hide')) {
    taskInner.classList.add('hide')
    formInline.classList.remove('hide')
    link.textContent = 'Cancel'
  } else {
    taskInner.classList.remove('hide')
    formInline.classList.add('hide')
    if (resourceErrors) resourceErrors.classList.add('hide')
    link.textContent = 'Edit'
  }
}
