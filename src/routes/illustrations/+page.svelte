<script lang="ts">
	import Gallery from '$lib/components/Gallery.svelte';
	import allImages from '$lib/config/images.js';
	import groups from '$lib/config/imageGroups.js';
</script>

<Gallery {allImages} selection={groups.illustrations} />
