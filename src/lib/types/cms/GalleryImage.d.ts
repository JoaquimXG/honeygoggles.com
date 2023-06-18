import type { FileType } from '@directus/sdk';
import type { BaseDirectusModel, DirectusStatus } from './base';

type GalleryImage = {
	Title: string;
	Blurb: string;
	Image: FileType;
} & BaseDirectusModel &
	DirectusStatus;

export default GalleryImage;
