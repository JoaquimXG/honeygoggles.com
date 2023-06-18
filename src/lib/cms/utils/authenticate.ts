import privateSettings from '$lib/settings/private';
import publicSettings from '$lib/settings/public';

import type { DirectusCollections } from '$lib/types/cms';
import type { Directus as TDirectus } from '@directus/sdk';
import { Directus } from '@directus/sdk';

export default async function (): Promise<TDirectus<DirectusCollections>> {
	const directus = new Directus<DirectusCollections>(publicSettings.CMS_HOST);
	// AUTHENTICATION
	let authenticated = false;

	// Let's login in case we don't have token or it is invalid / expired
	while (!authenticated) {
		await directus.auth
			.login({ email: publicSettings.CMS_EMAIL, password: privateSettings.CMS_PASSWORD })
			.then(() => {
				authenticated = true;
			})
			.catch(() => {
				console.error('Error authenticating with Directus');
			});
	}

	return directus;
}
