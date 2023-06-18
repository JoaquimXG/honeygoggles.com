<script lang="ts">
	import settings from '$lib/settings/public';
	import GalleryImage from './GalleryImage.svelte';
	import GalleryModal from './GalleryModal.svelte';

	import type { Gallery as TGallery, GalleryImage as TGalleryImage } from '$lib/types/cms/';

	export let gallery: TGallery;

	let images = gallery.Images.map((image) => image.GalleryImage_id);

	function splitToNChunks(array: TGalleryImage[], n: number): TGalleryImage[][] {
		let copy = [...array];
		let result: TGalleryImage[][] = [];
		for (let i = 0; i < n; i++) {
			let chunk: TGalleryImage[] = [];
			for (let j = i; j < copy.length; j = j + n) {
				chunk.push(copy[j]);
			}
			result.push(chunk);
		}
		return result;
	}

	let columnConfigs = [
		{
			columns: 4,
			imageColumns: splitToNChunks(images, 4),
			breakpointMin: 'xl:flex',
			breakpointMax: null
		},
		{
			columns: 3,
			imageColumns: splitToNChunks(images, 3),
			breakpointMin: 'lg:flex',
			breakpointMax: 'xl:hidden'
		},
		{
			columns: 2,
			imageColumns: splitToNChunks(images, 2),
			breakpointMin: 'sm:flex',
			breakpointMax: 'lg:hidden'
		},
		{
			columns: 1,
			imageColumns: [images],
			breakpointMin: null,
			breakpointMax: 'sm:hidden'
		}
	];

	let modalOpen = false;
	let modalImageIndex = 0;
	function handleSelect(image: TGalleryImage, e: Event) {
		/**
		 * Progressive enhancement
		 *  If JavaScript is enabled, when the image is selected we open a model to flick through images
		 *  If JavaScript is disabled, we just open the link for the image
		 */
		e.preventDefault();
		modalOpen = false;
		if (e.type === 'keydown' && (e as KeyboardEvent).key !== 'Enter') return;
		modalImageIndex = images.findIndex((_image: TGalleryImage) => image == _image);
		modalOpen = true;
	}
</script>

<GalleryModal {images} bind:imageIndex={modalImageIndex} bind:open={modalOpen} />

<div class="mt-6">
	{#each columnConfigs as conf}
		<div
			class="
        {conf.breakpointMin ? `hidden ${conf.breakpointMin} ` : ''}
        {conf.breakpointMax ? conf.breakpointMax : ''} gap-2"
		>
			{#each conf.imageColumns as imageColumn}
				<div class="flex flex-col gap-2">
					{#each imageColumn as image}
						<!--TODO this a tag should relate to an existing sveltekit route, not directly link to S3 bucket, clicking this should open the modal -->
						<a
							href="{settings.MEDIA_ROOT}/{image.Image.filename_disk}"
							on:click={(e) => handleSelect(image, e)}><GalleryImage {image} /></a
						>
					{/each}
				</div>
			{/each}
		</div>
	{/each}
</div>
