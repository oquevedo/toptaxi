# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  window.bindForms = () ->
    $(".reply_form").unbind('ajax:success').bind 'ajax:success', (xhr, data, status) ->
      # se esconde el formulario
      $(".reply_form").hide()
      # se obtiene el id en donde se sumara el comentario
      response_id = $("#response-to-id").val()
      $("#responses-"+response_id).append(data)
      $('#real-reply-comment-' + response_id).removeClass('active')

@reply_form = (comment_id, response_id) ->
  elem = $('#reply-comment-' + comment_id)
  if !elem.hasClass('active')
    elem.load '/new_reply?parent_comment_id=' + comment_id
    $('#response-to-id').val response_id
  else
    elem.html ''
  elem.toggleClass 'active'

@reply_nested_form = (comment_id, response_id) ->
  elem = $('#real-reply-comment-' + response_id)
  if !elem.hasClass('active')
    elem.load '/new_reply?parent_comment_id=' + comment_id
    $('#response-to-id').val response_id
    top = elem.offset().top
    window.scrollTo(0, top)
  else
    elem.html ''
  elem.toggleClass 'active'

@first_comment = () ->
  $(".reply_form_original").unbind('ajax:success').bind 'ajax:success', (xhr, data, status) ->
    $("#comment_body").val("")
    $("#original-comments").append(data)