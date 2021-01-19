// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(window).on("load", () => {
    console.log( "ready!" )

    $( ".register-btn" ).on( "click" , e => {
        e.preventDefault()
        $( ".register-form" ).toggleClass("hidden")
        $( ".login-form" ).toggleClass("hidden")
        $( ".login-label" ).toggleClass("hidden")
        $( ".register-label" ).toggleClass("hidden")
    })

    voteListeners()
})

const voteListeners = () => {

    $('.upvote').on("click", e => ajaxVote(e, 'up'))
    $('.downvote').on("click", e => ajaxVote(e, 'down'))

    $('.comment-upvote').on("click", e => ajaxCommentVote(e, 'up'))
    $('.comment-downvote').on("click", e => ajaxCommentVote(e, 'down'))

}

const ajaxVote = (e, value) => {
    e.preventDefault()
    const postId = $(e.currentTarget).attr('data-post')

    $.ajax({
        url: `/ajax/vote/${postId}/${value}`,
        success: result => {
            const value = result.vote.value
            const points = result.points

            // change arrow
            if(value == 1){
                $(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
                $(e.currentTarget).closest('.votes').find('.downvote').html("<img src='/assets/arrow.png'/>")
            }
            else if(value == -1){
                $(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
                $(e.currentTarget).closest('.votes').find('.upvote').html("<img src='/assets/arrow.png'/>")
            }
            else {
                $(e.currentTarget).html("<img src='/assets/arrow.png'/>")
            }

            // change points text
            if(points == 1 || points == -1){
                $(e.currentTarget).closest('.list-post').find('.points').html(`${points} point`)
            } else {
                $(e.currentTarget).closest('.list-post').find('.points').html(`${points} points`)
            }

        }
    })
}


const ajaxCommentVote = (e, value) => {
    e.preventDefault()
    const commentId = $(e.currentTarget).attr('data-comment')

    $.ajax({
        url: `/ajax/comment_vote/${commentId}/${value}`,
        success: result => {
            const value = result.vote.value
            const points = result.points

            // change arrow
            if(value == 1){
                $(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
                $(e.currentTarget).closest('.comment-votes').find('.comment-downvote').html("<img src='/assets/arrow.png'/>")
            }
            else if(value == -1){
                $(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
                $(e.currentTarget).closest('.comment-votes').find('.comment-upvote').html("<img src='/assets/arrow.png'/>")
            }
            else {
                $(e.currentTarget).html("<img src='/assets/arrow.png'/>")
            }

            // change points text
            if(points == 1 || points == -1){
                $(e.currentTarget).closest('.comment').find('.points').html(`${points} point`)
            } else {
                $(e.currentTarget).closest('.comment').find('.points').html(`${points} points`)
            }

        }
    })
}