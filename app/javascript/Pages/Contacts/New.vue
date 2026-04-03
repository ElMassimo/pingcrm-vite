<template>
  <Head title="Create Contact" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <inertia-link
        class="text-indigo-400 hover:text-indigo-600"
        :href="$api.contacts.list.path()"
      >
        Contacts
      </inertia-link>
      <span class="text-indigo-400 font-medium">/</span> Create
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="$api.contacts.create({ form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Create Contact
          </loading-button>
        </div>
      </contact-form>
    </div>
  </div>
</template>

<script>
import LoadingButton from '@/Shared/LoadingButton.vue'
import ContactForm from './Form.vue'
import { Head, useForm } from '@inertiajs/vue3'

export default {
  components: {
    Head,
    LoadingButton,
    ContactForm,
  },
  props: {
    organizations: {
      type: Array,
      required: true,
    },
  },
  setup () {
    const form = useForm({
      contact: {},
    })
    return { form }
  },
}
</script>
