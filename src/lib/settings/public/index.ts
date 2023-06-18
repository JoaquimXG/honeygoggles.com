import { PUBLIC_SETTINGS_ENV } from '$env/static/public';
import base from './base';
const environments = {
	base
};

export default environments[PUBLIC_SETTINGS_ENV];
