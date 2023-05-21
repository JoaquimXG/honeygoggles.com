<script lang="ts">
	import GalleryImage from "./GalleryImage.svelte";

	export let images: string[];

	const IMAGE_FOLDER = '/images/';

	function splitToNChunks(array: string[], n: number): string[][] {
		let copy = [...array];
		let result: string[][] = [];
		for (let i = n; i > 0; i--) {
			result.push(copy.splice(0, Math.ceil(copy.length / i)));
		}
		return result;
	}

	let columnConfigs = [
		{
			columns: 4,
			imageColumns: splitToNChunks(images, 4),
			breakpointMin: 'xl',
			breakpointMax: null
		},
		{
			columns: 3,
			imageColumns: splitToNChunks(images, 3),
			breakpointMin: 'lg',
			breakpointMax: 'xl'
		},
		{
			columns: 2,
			imageColumns: splitToNChunks(images, 2),
			breakpointMin: 'sm',
			breakpointMax: 'lg'
		},
		{
			columns: 1,
			imageColumns: [images],
			breakpointMin: null,
			breakpointMax: 'sm'
		}
	];
</script>

<!-- Flex columns using columns variable-->
<div class="mt-6">
	{#each columnConfigs as conf}
		<div
			class="
        {conf.breakpointMin ? `hidden ${conf.breakpointMin}:flex ` : ''}
        {conf.breakpointMax ? `${conf.breakpointMax}:hidden` : ''} gap-2"
		>
			{#each conf.imageColumns as imageColumn}
				<div class="flex flex-col gap-2" tabindex="0">
					{#each imageColumn as image}
						<GalleryImage {image} alt="TODO" />
					{/each}
				</div>
			{/each}
		</div>
	{/each}
</div>
