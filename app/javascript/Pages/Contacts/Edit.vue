<template>
  <Head :title="`${form.contact.first_name} ${form.contact.last_name}`" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <inertia-link
        class="text-indigo-500 hover:text-indigo-800"
        :href="$api.contacts.list.path()"
      >
        Contacts
      </inertia-link>
      <span class="text-indigo-400 font-medium">/</span>
      {{ form.contact.first_name }} {{ form.contact.last_name }}
    </h1>
    <trashed-message
      v-if="contact.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This contact has been deleted.
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="$api.contacts.update({ params: contact, form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <button
            v-if="!contact.deleted_at"
            class="text-red-700 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete Contact
          </button>
          <loading-button
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update Contact
          </loading-button>
        </div>
      </contact-form>
    </div>
  </div>
</template>

<script>
import LoadingButton from '@/Shared/LoadingButton.vue'
import TrashedMessage from '@/Shared/TrashedMessage.vue'
import ContactForm from './Form.vue'
import { Head, useForm } from '@inertiajs/vue3'
import omit from 'lodash/omit'

export default {
  components: {
    Head,
    LoadingButton,
    ContactForm,
    TrashedMessage,
  },
  props: {
    contact: {
      type: Object,
      required: true,
    },
    organizations: {
      type: Array,
      required: true,
    },
  },
  setup (props) {
    const form = useForm({
      contact: omit(props.contact, 'id', 'deleted_at'),
    })
    return { form }
  },
  methods: {
    destroy () {
      if (confirm('Are you sure you want to delete this contact?'))
        this.$api.contacts.destroy(this.contact)
    },
    restore () {
      if (confirm('Are you sure you want to restore this contact?'))
        this.$api.contacts.restore(this.contact)
    },
  },
}
</script>
