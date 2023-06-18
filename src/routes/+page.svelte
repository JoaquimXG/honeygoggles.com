<script lang="ts">
	import Gallery from '$lib/components/Gallery.svelte';
	import groups from '$lib/config/imageGroups.js';
	import allImages from '$lib/config/images.js';
</script>

<Gallery {allImages} selection={groups.home} />
