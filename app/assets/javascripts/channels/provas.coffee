# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#       $("#resultado_dhroficial").val(null)
#       $("#resultado_posicao").val(null)
#       $("#resultado_pontos").val(null)
#       $("#resultado_dhrestimada").val(null)

$(document).on 'click', 'input:radio', (evt) ->
  val = $(this).attr('value')
  if val is 'P'
    $("#parcial").show()
    $("#oficial").hide()
  else
    $("#oficial").show()
    $("#parcial").hide()
    
  
    