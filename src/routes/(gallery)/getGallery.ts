import GalleryImageQuery from '$lib/cms/queries/gallery';
import privateSettings from '$lib/settings/private';
import publicSettings from '$lib/settings/public';

import type { Gallery } from '$lib/types/cms';
import { request } from 'graphql-request';

export default async (name: string): Promise<Gallery> => {
	// TODO filter by draft/not draft
	const response: { Gallery: Gallery[] } = await request({
		url: publicSettings.CMS_HOST + '/graphql',
		document: GalleryImageQuery,
		requestHeaders: {
			Authorization: `Bearer ${privateSettings.CMS_TOKEN}`
		}
	});
	const gallery = response.Gallery.find((g) => g.slug === name);

	if (!gallery) throw "Couldn't find gallery";

	return gallery;
};
