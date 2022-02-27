export const ajaxCommentVote = (e, value) => {
	e.preventDefault()
	const commentId = $(e.currentTarget).attr('data-comment')

	$.ajax({
		url: `/ajax/comment_vote/${commentId}/${value}`,
		success: result => post_api(result, e),
	})
}

function post_api(result, e) {
	e.preventDefault()
	e.stopPropagation()

	console.log('ready 2')

	if (!result.vote) return $('.error').html(`<p> ${result.error} </p>`)

	// points arrow
	const value = result.vote.value
	const closest = $(e.currentTarget)

	if (value == 1) {
		closest.html("<img src='/assets/arrow_orange.png'/>")
		closest
			.closest('.comment-votes')
			.find('.comment-downvote')
			.html("<img src='/assets/arrow.png'/>")
	} else if (value == -1) {
		closest.html("<img src='/assets/arrow_orange.png'/>")
		closest
			.closest('.comment-votes')
			.find('.comment-upvote')
			.html("<img src='/assets/arrow.png'/>")
	} else {
		closest.html("<img src='/assets/arrow.png'/>")
	}

	// points text
	closest
		.parentsUntil('.comment')
		.find('.points')
		.html(`${result.points} points`)
}

export const commentReply = e => {
	e.preventDefault()

	$(e.currentTarget)
		.closest('.comment')
		.find('.comment-reply-form:first')
		.toggleClass('hidden')
}

export const editFormReveal = e => {
	e.preventDefault()

	$(e.currentTarget)
		.closest('.comment')
		.find('.comment-edit-form:first')
		.toggleClass('hidden')
}
