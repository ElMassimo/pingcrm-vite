<template>
  <organization-form
    v-model="form"
    class="bg-white max-w-3xl"
    @submit="submit(form)"
  >
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
      <loading-button
        :loading="form.processing"
        class="btn-indigo"
        type="submit"
      >
        Create Organization
      </loading-button>
    </div>
  </organization-form>
</template>

<script lang="ts">
import LoadingButton from '@/Shared/LoadingButton.vue'
import api from '@/api'
import type { OrganizationEdit } from '@/types/serializers'
import OrganizationForm from './Form.vue'

interface OrganizationNewFormPayload {
  organization: Partial<OrganizationEdit>
}

export default {
  components: {
    LoadingButton,
    OrganizationForm,
  },
  remember: 'form',
  data () {
    return {
      form: this.$inertia.form({
        organization: {},
      }) as OrganizationNewFormPayload & { processing: boolean; reset: (...fields: string[]) => void },
    }
  },
  methods: {
    submit (form: OrganizationNewFormPayload & { reset: (...fields: string[]) => void }) {
      api.organizations.create({
        form,
        onSuccess: () => {
          this.$emit('success')
          form.reset('organization')
        },
      })
    },
  },
}
</script>
