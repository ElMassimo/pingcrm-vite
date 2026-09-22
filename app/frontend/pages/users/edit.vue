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
const { user, can } = defineProps<{
  user: UserFormData
  can: { edit_user: boolean }
}>()
const form = useForm<{ user: UserData }>({
  user: { ...user, photo: null },
})
const title = $computed(() => `${form.user.first_name} ${form.user.last_name}`)

function submit () {
  users.update({
    params: user,
    form,
    onSuccess: () => form.reset('user.password', 'user.photo'),
  })
}

function destroy () {
  if (confirm('Are you sure you want to delete this user?')) users.destroy(user)
}

function restore () {
  if (confirm('Are you sure you want to restore this user?')) users.restore(user)
}
</script>

<template>
  <Head :title="title" />
  <div>
    <div class="mb-8 flex justify-start max-w-3xl">
      <h1 class="font-bold text-3xl">
        <InertiaLink
          class="text-indigo-500 hover:text-indigo-600"
          :href="users.index.path()"
        >
          Users
        </InertiaLink>
        <span class="text-indigo-400 font-medium">/</span>
        {{ form.user.first_name }} {{ form.user.last_name }}
      </h1>
      <img
        v-if="user.photo"
        class="block w-8 h-8 rounded-full ml-4"
        :src="user.photo"
        alt="Photo"
      >
    </div>
    <TrashedMessage
      v-if="user.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This user has been deleted.
    </TrashedMessage>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <UserForm
        v-model="form"
        @submit="submit"
      >
        <div
          v-if="can.edit_user"
          class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center"
        >
          <button
            v-if="!user.deleted_at"
            class="text-red-800 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete User
          </button>
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update User
          </LoadingButton>
        </div>
      </UserForm>
    </div>
  </div>
</template>
