import type { DirectusBaseModel, DirectusStatus } from './base';
import type GalleryImage from './GalleryImage';

type Gallery = {
	Title: string;
	Images: { GalleryImage_id: GalleryImage }[];
	slug: string;
} & DirectusBaseModel &
	DirectusStatus;

export default Gallery;
