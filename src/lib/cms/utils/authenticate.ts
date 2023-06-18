import settings from '$lib/settings/base';
import type { DirectusCollections } from '$lib/types/cms';
import type { Directus as TDirectus } from '@directus/sdk';
import { Directus } from '@directus/sdk';

export default async function (): Promise<TDirectus<DirectusCollections>> {
	const directus = new Directus<DirectusCollections>(settings.CMS_HOST);
	// AUTHENTICATION
	let authenticated = false;

	// Let's login in case we don't have token or it is invalid / expired
	while (!authenticated) {
		await directus.auth
			.login({ email: settings.CMS_EMAIL, password: settings.CMS_PASSWORD })
			.then(() => {
				authenticated = true;
				console.log('Authenticated#########');
			})
			.catch(() => {
				window.alert('Invalid credentials');
			});
	}

	return directus;
}
