import type { BaseDirectusModel, DirectusStatus } from './base';
import type GalleryImage from './GalleryImage';

type Gallery = {
	Title: string;
	Images: GalleryImage[];
} & BaseDirectusModel &
	DirectusStatus;
