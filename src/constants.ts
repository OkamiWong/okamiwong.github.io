import type { Props } from 'astro'
import IconMail from '@/assets/icons/IconMail.svg'
import IconGitHub from '@/assets/icons/IconGitHub.svg'

interface Social {
  name: string
  href: string
  linkTitle: string
  icon: (_props: Props) => Element
}

export const SOCIALS: Social[] = [
  {
    name: 'GitHub',
    href: 'https://github.com/OkamiWong',
    linkTitle: `Check my GitHub home page`,
    icon: IconGitHub,
  },
  {
    name: 'Mail',
    href: 'mailto:wtfimba@live.com',
    linkTitle: `Send an email to me`,
    icon: IconMail,
  },
] as const
