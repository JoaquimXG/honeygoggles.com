<script lang="ts">
	import type { GalleryImage } from '$lib/types/cms/';
	import GalleryModalArrow from './GalleryModalArrow.svelte';
	import settings from '$lib/settings/public';

	export let imageIndex: number;
	export let open: boolean;
	export let images: GalleryImage[];

	$: showLeft = imageIndex > 0;
	$: showRight = imageIndex < images.length - 1;

	$: src = settings.MEDIA_ROOT + '/' + images[imageIndex].Image.filename_disk;
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
		direction="left"
		bind:show={showLeft}
	/>
	<div
		on:click|stopPropagation
		on:keydown|stopPropagation
		class="cursor-default max-w-screen-md w-5/6 modal-box p-6 px-11 relative max-h-4/5 prose"
	>
		<h3 class="text-info">{image.Title}</h3>
		<p class="text-primary-content">{image.Blurb}</p>

		<img id="modal-image" {src} alt={image.title} class="rounded-lg h-full w-full mt-4" />
	</div>
	<GalleryModalArrow
		on:click={navigateRight}
		direction="right"
		bind:show={showRight}
	/>
</label>
