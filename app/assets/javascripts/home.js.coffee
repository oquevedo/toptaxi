# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ -> 
  # $('.slidemenu-trigger').click ->
  #   if $('body').hasClass("slide-active")
  #     $(".slidemenu").stop().animate({ left: '-100%'})
  #     $(".contGeneral").stop().animate({ left: '0%'})
  #   else
  #     $(".slidemenu").stop().animate({ left: '0%'})
  #     $(".contGeneral").stop().animate({ left: '80%'})
  #   $('body').toggleClass("slide-active")
  $(".toggle_with").click ->
    toogle_with($(this))
    
  self.toogle_with = (node) ->
    $(node.attr("hide")).hide()
    $(node.attr("target")).show()

  $('.slidemenu-trigger').click ->
    if $('body').hasClass("slide-active")
      $(".transition").stop().animate({ left: '-100%'})
    else
      $(".transition").stop().animate({ left: '-20%'})
    $('body').toggleClass("slide-active")

  $(window).resize ->
    $(".transition").attr('style','')
 
$(document).on "change", ".btn-file :file", ->
  input = $(this)
  numFiles = (if input.get(0).files then input.get(0).files.length else 1)
  label = input.val().replace(/\\/g, "/").replace(/.*\//, "")
  input.trigger "fileselect", [
    numFiles
    label
  ]
  return

$(document).ready ->
  $(".btn-file :file").on "fileselect", (event, numFiles, label) ->
    input = $(this).parents(".input-group").find(":text")
    log = (if numFiles > 1 then numFiles + " files selected" else label)
    if input.length
      input.val log
    else
      # alert log  if log
    return

  return