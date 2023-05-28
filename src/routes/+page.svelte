<script lang="ts">
	import Gallery from '$lib/components/Gallery.svelte';
	import images from './images.js';
	let _images = images.sort();
</script>

<Gallery images={_images} />
