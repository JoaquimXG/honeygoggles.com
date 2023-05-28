<script lang="ts">
	import type { Image } from '$lib/types/Image';

	export let image: Image;

	const IMAGE_FOLDER = '/images/';
	const src = IMAGE_FOLDER + image.name;
</script>

<div class="group bg-white relative cursor-pointer">
	<img class="block group-hover:opacity-10 transition-opacity" {src} alt={image.caption} />
	<div
		class="absolute opacity-0 group-hover:opacity-100 h-fit top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
	>
		<h3 class="text-black text-2xl mx-auto h-full">{image.title}</h3>
	</div>
</div>
