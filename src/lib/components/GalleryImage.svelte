<script lang="ts">
	import settings from '$lib/settings/public';
	import type { GalleryImage } from '$lib/types/cms/';

	export let image: GalleryImage;

	const src = settings.MEDIA_ROOT + '/' + image.Image.filename_disk;
</script>

<div class="group bg-white relative cursor-pointer">
	<img class="block group-hover:opacity-10 transition-opacity" {src} alt={image.Blurb} />
	<div
		class="absolute opacity-0 group-hover:opacity-100 h-fit top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
	>
		<h3 class="text-black text-2xl mx-auto h-full">{image.Title}</h3>
	</div>
</div>
