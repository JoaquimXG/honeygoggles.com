import { SETTINGS_ENV } from '$env/static/private';
import base from './base';
const environments = {
	base
};

export default environments[SETTINGS_ENV];
