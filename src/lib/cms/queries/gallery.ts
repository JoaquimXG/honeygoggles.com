// Write GraphQl Query for Gallery object
import { gql } from 'graphql-request';

export default gql`
	query GalleryImage {
		Gallery {
			Title
			status
			slug
			Images {
				Order
				id
				GalleryImage_id {
					Blurb
					Title
					status
					Image {
						filename_disk
						filename_download
						type
						width
						height
						description
					}
				}
			}
		}
	}
`;
