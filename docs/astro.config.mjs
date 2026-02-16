// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://infrashift.github.io',
	base: '/trusted-base-images',
	integrations: [
		starlight({
			title: 'Trusted Base Images',
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/infrashift/trusted-base-oci-images' },
			],
			editLink: {
				baseUrl: 'https://github.com/infrashift/trusted-base-oci-images/edit/main/docs/',
			},
			customCss: ['./src/styles/custom.css'],
			sidebar: [
				{
					label: 'Image Catalog',
					items: [
						{ label: 'Overview', slug: 'images' },
						{
							label: 'UBI9',
							items: [
								{ label: 'Standard', slug: 'images/ubi9-standard' },
								{ label: 'Minimal', slug: 'images/ubi9-minimal' },
								{ label: 'Micro', slug: 'images/ubi9-micro' },
								{ label: 'Init', slug: 'images/ubi9-init' },
							],
						},
						{
							label: 'UBI10',
							items: [
								{ label: 'Minimal', slug: 'images/ubi10-minimal', badge: { text: 'amd64 only', variant: 'caution' } },
							],
						},
					],
				},
				{
					label: 'Inventory',
					items: [
						{ label: 'Overview', slug: 'inventory' },
						{ label: 'UBI9 Standard', slug: 'inventory/ubi9-standard' },
						{ label: 'UBI9 Minimal', slug: 'inventory/ubi9-minimal' },
						{ label: 'UBI9 Micro', slug: 'inventory/ubi9-micro' },
						{ label: 'UBI9 Init', slug: 'inventory/ubi9-init' },
						{ label: 'UBI10 Minimal', slug: 'inventory/ubi10-minimal', badge: { text: 'amd64 only', variant: 'caution' } },
					],
				},
				{
					label: 'Guides',
					items: [
						{ label: 'Pulling Images', slug: 'guides/pulling-images' },
						{ label: 'Verify Attestations', slug: 'guides/verify-attestations' },
						{ label: 'Verify Signatures', slug: 'guides/verify-signatures' },
						{ label: 'Compare Checksums', slug: 'guides/compare-checksums' },
					],
				},
				{
					label: 'Security',
					items: [
						{ label: 'Governance Model', slug: 'security/governance-model' },
						{ label: 'Namespace Isolation', slug: 'security/namespace-isolation' },
						{ label: 'Supply Chain', slug: 'security/supply-chain' },
						{ label: 'Digest Pinning', slug: 'security/digest-pinning' },
						{ label: 'Image Annotations', slug: 'security/image-annotations' },
						{ label: 'CVE Monitoring', slug: 'security/cve-monitoring' },
					],
				},
				{
					label: 'Reference',
					items: [
						{ label: 'Architecture', slug: 'reference/architecture' },
						{ label: 'versions.json Schema', slug: 'reference/versions-json' },
						{ label: 'Contributing', slug: 'reference/contributing' },
						{ label: 'Roadmap', slug: 'reference/roadmap' },
						{ label: 'Thank You', slug: 'reference/thank-you' },
					],
				},
			],
		}),
	],
});
