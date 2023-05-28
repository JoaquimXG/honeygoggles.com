<script lang="ts">
	import '../app.css';
	import NavLink from '$lib/components/NavLink.svelte';
	import BurgerMenu from '$lib/icons/BurgerMenu.svelte';
	import Logo from '$lib/components/Logo.svelte';
	import menu from '$lib/config/menu';
</script>

<div class="mx-auto p-6">
	<div class="navbar bg-base-100">
		<div class="navbar-start">
			<Logo />
			<div class="hidden md:flex">
				{#each menu as menuItem}
					{#if !menuItem.hideMobile}
						<NavLink href={menuItem.href}>{menuItem.text}</NavLink>
					{/if}
				{/each}
			</div>
		</div>
		<div class="navbar-end">
			<div class="dropdown dropdown-end">
				<label tabindex="0" class="btn btn-ghost md:hidden">
					<BurgerMenu />
				</label>
				<ul
					tabindex="0"
					class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-200 rounded-box w-52"
				>
					{#each menu as menuItem}
						<li>
							<a href={menuItem.href}>{menuItem.text}</a>
						</li>
					{/each}
				</ul>
			</div>
		</div>
	</div>
	<slot />
</div>
