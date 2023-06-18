<script lang="ts">
	export let direction: 'left' | 'right' = 'left';
	export let show: boolean;

	let baseClasses =
		'w-8 transition-all hover:bg-black fill-black hover:fill-white rounded-full p-2';
	let classes = baseClasses + (direction === 'left' ? ' mr-2' : ' ml-2');
</script>

<div
	tabindex="0"
	on:click|stopPropagation
	on:keydown|stopPropagation
	class={`${classes} ${show ? 'opacity-100' : 'opacity-0'}`}
>
	{#if direction === 'left'}
		<svg
			version="1.1"
			id="Layer_1"
			xmlns="http://www.w3.org/2000/svg"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			x="0px"
			y="0px"
			viewBox="0 0 512 512"
			style="enable-background:new 0 0 512 512;"
			xml:space="preserve"
		>
			<g id="XMLID_1_">
				<path
					id="XMLID_3_"
					d="M467.3,210H156.1L277,94.2c17.5-18.4,17.5-47.3,0-65.8c-17.5-18.4-45.6-18.4-63.1,0L13.2,224   C4.4,232.8,0,244.2,0,256.4l0,0c0,12.3,4.4,24.5,13.2,32.4l200.8,194.6c17.5,18.4,45.6,18.4,63.1,0c17.5-18.4,17.5-47.3,0-65.8   l-121-114.8h311.2c24.5,0,44.7-21,44.7-46.5C512,230.1,491.8,210,467.3,210L467.3,210z"
				/>
			</g>
		</svg>
	{:else}
		<svg
			version="1.1"
			id="Layer_1"
			xmlns="http://www.w3.org/2000/svg"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			x="0px"
			y="0px"
			viewBox="0 0 520 520"
			style="enable-background:new 0 0 512 512;"
			xml:space="preserve"
		>
			<g id="XMLID_1_">
				<path
					id="XMLID_3_"
					d="M297.7,483.6l200.9-194.6c8.7-8.7,13.4-19.7,13.4-32.3V256c0-12.6-4.7-24.4-13.4-32.3L297.7,28.4   c-17.3-18.1-45.7-18.1-63,0s-17.3,47.3,0,65.4l120.5,115.8H44.9C20.5,209.5,0,230,0,256c0,26,19.7,46.5,44.9,46.5H356L234.7,418.3   c-17.3,18.1-17.3,47.3,0,65.4C252.8,501.8,280.4,501.8,297.7,483.6L297.7,483.6z"
				/>
			</g>
		</svg>
	{/if}
</div>
