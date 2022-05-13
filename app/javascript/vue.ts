import Vue from 'vue'
import VueMeta from 'vue-meta'
import PortalVue from 'portal-vue'
import { Head, Link } from '@inertiajs/inertia-vue'
import ConstantsMixin from '~/utils/ConstantsMixin'
import api from '~/api'

Vue.use(VueMeta)
Vue.use(PortalVue)
Vue.component('InertiaHead', Head as any)
Vue.component('InertiaLink', Link as any)
Vue.mixin(ConstantsMixin)
Vue.prototype.$api = api

export default Vue
