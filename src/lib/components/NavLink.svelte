<script lang="ts">
	export let href: string;
	export let underline: boolean = false;

	let classes = 'no-animation hover:bg-base-100 btn btn-ghost normal-case text-xl';

	if (underline) {
		classes += ' link link-hover';
	}
</script>

<a {href} class={classes}><slot /></a>
