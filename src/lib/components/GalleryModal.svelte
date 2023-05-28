<script lang="ts">
	import GalleryModalArrow from './GalleryModalArrow.svelte';
	export let imageIndex: number;
	export let alt: string;
	export let open: boolean;
	export let images: string[];

	$: showLeft = imageIndex > 0;
	$: showRight = imageIndex < images.length - 1;

	const IMAGE_FOLDER = '/images/';
	$: src = IMAGE_FOLDER + images[imageIndex];

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
	<div on:click|stopPropagation on:keydown|stopPropagation class="modal-box p-2 relative max-h-4/5">
		<img {src} {alt} class="rounded-lg h-full" />
	</div>
	<GalleryModalArrow
		on:click={navigateRight}
		on:keydown={navigateRight}
		direction="right"
		bind:show={showRight}
	/>
</label>
