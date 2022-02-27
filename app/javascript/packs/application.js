// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

import { ajaxVote } from './post'
import { ajaxCommentVote, commentReply, editFormReveal } from './comment'

var jQuery = require('jquery')

global.$ = global.jQuery = jQuery
window.$ = window.jQuery = jQuery

Rails.start()
Turbolinks.start()
ActiveStorage.start()

const ready = () => {
	$('.register-btn').on('click', e => {
		e.preventDefault()
		$('.register-form').toggleClass('hidden')
		$('.login-form').toggleClass('hidden')
		$('.login-label').toggleClass('hidden')
		$('.register-label').toggleClass('hidden')
	})

	$('.upvote').on('click', e => ajaxVote(e, 'up'))
	$('.downvote').on('click', e => ajaxVote(e, 'down'))

	$('.comment-upvote').on('click', e => ajaxCommentVote(e, 'up'))
	$('.comment-downvote').on('click', e => ajaxCommentVote(e, 'down'))

	$('.comment-edit').on('click', editFormReveal)
	$('.comment-reply').on('click', commentReply)
}

// $(window).on('load', ready)
$(window).on('turbolinks:load', ready)
