export const ajaxVote = (e, value) => {
	e.preventDefault()
	const postId = $(e.currentTarget).attr('data-post')

	$.ajax({
		url: `/ajax/vote/${postId}/${value}`,
		success: result => post_api(result, e),
	})
}

function post_api(result, e) {
	if (!result.vote) return $('.error').html(`<p> ${result.error} </p>`)

	const value = result.vote.value

	// change arrow
	if (value == 1) {
		$(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
		$(e.currentTarget)
			.closest('.votes')
			.find('.downvote')
			.html("<img src='/assets/arrow.png'/>")
	} else if (value == -1) {
		$(e.currentTarget).html("<img src='/assets/arrow_orange.png'/>")
		$(e.currentTarget)
			.closest('.votes')
			.find('.upvote')
			.html("<img src='/assets/arrow.png'/>")
	} else {
		$(e.currentTarget).html("<img src='/assets/arrow.png'/>")
	}

	// change points text
	$(e.currentTarget)
		.closest('.list-post')
		.find('.points')
		.html(`${result.points} points`)
}
