<script lang="ts">
	import Gallery from '$lib/components/Gallery.svelte';
	import type { Gallery as TGallery } from '$lib/types/cms/';

	export let data: { gallery: TGallery };

</script>

<Gallery gallery={data.gallery} />
