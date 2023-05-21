<script lang="ts">
	export let image: string;
	export let alt: string;

	const IMAGE_FOLDER = '/images/';
	const src = IMAGE_FOLDER + image;

	function handleClick() {
		console.log('clicked');
	}
</script>

<div on:click={handleClick} on:keydown={handleClick} class="group bg-white relative cursor-pointer">
	<img class="block group-hover:opacity-30 transition-opacity" {src} {alt} />
	<div
		class="absolute opacity-0 group-hover:opacity-100 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
	>
		<h3 class="text-black mx-auto">{alt}</h3>
	</div>
</div>
