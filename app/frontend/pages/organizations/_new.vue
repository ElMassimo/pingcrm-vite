<script setup lang="ts">
import { organizations } from '~/api'
import { useForm } from '~/composables/form'
import type { OrganizationForm as OrganizationFormData } from '~/serializers'
import OrganizationForm from './form.vue'

type OrganizationData = Omit<OrganizationFormData, 'id' | 'deleted_at'>
defineOptions({ remember: 'form' })
const emit = defineEmits<{ success: [] }>()
const form = useForm<{ organization: OrganizationData }>({
  organization: { name: '' },
})

function submit () {
  organizations.create({
    form,
    onSuccess: () => {
      emit('success')
      form.reset('organization')
    },
  })
}
</script>

<template>
  <OrganizationForm
    v-model="form"
    class="bg-white max-w-3xl"
    @submit="submit"
  >
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
      <LoadingButton
        :loading="form.processing"
        class="btn-indigo"
        type="submit"
      >
        Create Organization
      </LoadingButton>
    </div>
  </OrganizationForm>
</template>
