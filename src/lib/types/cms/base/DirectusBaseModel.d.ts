import type { ID } from '@directus/sdk';

type DirectusBaseModel = {
	id: ID;
	date_created: string;
	date_updated: string;
	user_created: string;
	user_updated: string;
	status: string;
};

export default DirectusBaseModel;
