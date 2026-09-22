<script setup lang="ts">
import { users } from '~/api'
import { useForm } from '~/composables/form'
import type { UserForm as UserFormData } from '~/serializers'
import UserForm from './form.vue'

type UserData = Omit<UserFormData, 'id' | 'deleted_at' | 'photo'> & {
  password?: string
  photo: File | null
}
defineOptions({ remember: 'form' })
const { user } = defineProps<{ user: UserFormData }>()
const form = useForm<{ user: UserData }>({
  user: { ...user, photo: null },
})
</script>

<template>
  <Head title="Create User" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <InertiaLink
        class="text-indigo-400 hover:text-indigo-600"
        :href="users.index.path()"
      >
        Users
      </InertiaLink>
      <span class="text-indigo-400 font-medium">/</span> Create
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <UserForm
        v-model="form"
        @submit="users.create({ form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Create User
          </LoadingButton>
        </div>
      </UserForm>
    </div>
  </div>
</template>
