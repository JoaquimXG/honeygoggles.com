<script lang="ts">
	import GalleryImage from './GalleryImage.svelte';
	import GalleryModal from './GalleryModal.svelte';

	export let images: string[];

	// function splitToNChunks(array: string[], n: number): string[][] {
	// 	let copy = [...array];
	// 	let result: string[][] = [];
	// 	for (let i = n; i > 0; i--) {
	// 		result.push(copy.splice(0, Math.ceil(copy.length / i)));
	// 	}
	// 	return result;
	// }

	function splitToNChunks(array: string[], n: number): string[][] {
		let copy = [...array];
		let result: string[][] = [];
		for (let i = 0; i < n; i++) {
			let chunk: string[] = [];
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

	let modalImage = '';
	let modalAlt = '';
	let modalOpen = false;
	let modalImageIndex = 0;
	function handleSelect(image: string, alt: string, e: Event) {
		/**
		 * Progressive enhancement
		 *  If JavaScript is enabled, when the image is selected we open a model to flick through images
		 *  If JavaScript is disabled, we just open the link for the image
		 */
		e.preventDefault();
		modalOpen = false;
		if (e.type === 'keydown' && (e as KeyboardEvent).key !== 'Enter') return;
		modalAlt = alt;
		modalImage = image;
		modalImageIndex = images.indexOf(image);
		modalOpen = true;
	}
</script>

<GalleryModal {images} bind:imageIndex={modalImageIndex} alt={modalAlt} bind:open={modalOpen} />

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
						<a href="/images/{image}" on:click={(e) => handleSelect(image, 'TODO', e)}
							><GalleryImage {image} alt="TODO" /></a
						>
					{/each}
				</div>
			{/each}
		</div>
	{/each}
</div>
