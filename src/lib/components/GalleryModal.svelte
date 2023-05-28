<script lang="ts">
	import type Image from '$lib/types/Image';
	import GalleryModalArrow from './GalleryModalArrow.svelte';

	export let imageIndex: number;
	export let open: boolean;
	export let images: Image[];

	$: showLeft = imageIndex > 0;
	$: showRight = imageIndex < images.length - 1;

	const IMAGE_FOLDER = '/images/';
	$: src = IMAGE_FOLDER + images[imageIndex].name;
	$: image = images[imageIndex];

	const close = () => {
		open = false;
	};

	const navigateLeft = () => {
		if (!showLeft) return;
		imageIndex = imageIndex - 1;
	};

	const navigateRight = () => {
		if (!showRight) return;
		imageIndex = imageIndex + 1;
	};
</script>

<label
	for="my-modal-4"
	on:click={close}
	on:keydown={close}
	class="modal {open ? 'modal-open' : ''} cursor-pointer bg-white bg-opacity-75"
>
	<GalleryModalArrow
		on:click={navigateLeft}
		on:keydown={navigateLeft}
		direction="left"
		bind:show={showLeft}
	/>
	<div
		on:click|stopPropagation
		on:keydown|stopPropagation
		class="cursor-default modal-box p-6 px-11 relative max-h-4/5 prose"
	>
		<h3 class="text-info">{image.title}</h3>
		<p class="text-primary-content">{image.caption.slice(0, 100)}</p>

		<img id="modal-image" {src} alt={image.title} class="rounded-lg h-full mt-4" />
	</div>
	<GalleryModalArrow
		on:click={navigateRight}
		on:keydown={navigateRight}
		direction="right"
		bind:show={showRight}
	/>
</label>
