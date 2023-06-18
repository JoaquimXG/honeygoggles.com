import authenticate from '$lib/cms/utils/authenticate';
import type { Gallery } from '$lib/types/cms';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async (): Promise<{ data?: Gallery[-1] }> => {
	const directus = await authenticate();

	// TODO filter by draft or not
	const data: { data?: Gallery[-1] } = await directus
		.items<string, Gallery[]>('Gallery')
		.readByQuery({ limit: -1 });
	return data;
};
