export default interface ContactEdit {
  id: number
  first_name: string
  last_name: string
  organization_id?: number
  email?: string
  phone?: string
  address?: string
  city?: string
  region?: string
  country?: string
  postal_code?: string
  deleted_at?: string
}
