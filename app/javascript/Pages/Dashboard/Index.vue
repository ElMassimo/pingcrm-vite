<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Dashboard
    </h1>
    <p class="mb-8 leading-normal">
      Hey there! Welcome to
      <ExternalLink href="https://github.com/ElMassimo/pingcrm-vite">
        Ping CRM
      </ExternalLink>, a demo app designed to help illustrate how
      <ExternalLink href="https://inertiajs.com">
        Inertia.js
      </ExternalLink>
      works with
      <ExternalLink href="https://rubyonrails.org/">
        Ruby on Rails
      </ExternalLink>.
    </p>
    <p class="mb-8 leading-normal">
      This demo is running on
      <ExternalLink href="https://vite-rails.netlify.app/">
        Vite ⚡️ Rails
      </ExternalLink>
      instead of Webpacker, which provides a
      <ExternalLink href="https://vite-rails.netlify.app/guide/introduction">
        faster development experience
      </ExternalLink>
      thanks to
      <ExternalLink href="https://vite-rails.netlify.app/guide/introduction">
        Vite
      </ExternalLink>.
    </p>

    <p class="mb-8 leading-normal">
      It also uses
      <ExternalLink href="https://js-from-routes.netlify.app/">
        JS From Routes
      </ExternalLink>
      to simplify navigation and making requests to the Rails server without hardcoding paths.
    </p>

    <p class="mb-10 leading-normal">
      Version
      <a :href="releaseUrl" class="hover:underline">{{ release.commit || 'development' }}</a>
      &minus;
      {{ relativeCommitTime }}
    </p>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main.vue'
import ExternalLink from '@/Shared/ExternalLink.vue'
import * as timeago from 'timeago.js'

export default {
  metaInfo: { title: 'Dashboard' },
  components: {
    ExternalLink,
  },
  layout: Layout,
  props: {
    release: { type: Object, required: true },
    repo: { type: Object, required: true },
  },
  computed: {
    relativeCommitTime () {
      return timeago.format(this.release.created_at)
    },
    releaseUrl () {
      return this.release.commit ? `${this.repo.url}/commit/${this.release.commit}` : this.repo.url
    },
  },
}
</script>
