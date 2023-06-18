import type { Gallery } from '$lib/types/cms';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

const galleryPages: string[] = ['illustrations'];
import getGallery from '../getGallery';

export const load: PageServerLoad = async ({ params }): Promise<{ gallery: Gallery }> => {
	if (!galleryPages.includes(params.name)) throw error(404, 'Not found');

	return { gallery: await getGallery(params.name) };
};
