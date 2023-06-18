import type { Gallery } from '$lib/types/cms';
import type { PageServerLoad } from './$types';

import getGallery from './getGallery';

export const load: PageServerLoad = async (): Promise<{ gallery: Gallery }> => {
	return { gallery: await getGallery('') };
};
