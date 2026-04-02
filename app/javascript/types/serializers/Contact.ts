import type Model from './Model'

export default interface Contact {
  id: number
  name: string
  phone?: string
  city?: string
  deleted_at?: string
  organization?: Model
}
