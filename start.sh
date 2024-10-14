npm install next@latest react@latest react-dom@latest
npm install --save-dev typescript tailwindcss
npx tailwind init

NEW_CONTENT='  content: ["./app/**/*.{js,ts,jsx,tsx,mdx}"'
sed -i '' "s|content: \[\]|$NEW_CONTENT|" tailwind.config.js

cat '{
  "compilerOptions": {
    "lib": [
      "dom",
      "dom.iterable",
      "esnext"
    ],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "incremental": true,
    "module": "esnext",
    "esModuleInterop": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/app/*": ["app/*"],
      "@/components/*": ["components/*"],
      "@/api/*": ["api/*"]
    },
    
  },
  "include": [
    "next-env.d.ts",
    ".next/types/**/*.ts",
    "**/*.ts",
    "**/*.tsx"
  ],
  "exclude": [
    "node_modules"
  ]
}' >> tsconfig.json

cat "module.exports = {
  plugins: {
    tailwindcss: {},
  },
}" >> postcss.config.js

cat "@tailwind base;
@tailwind components;
@tailwind utilities;" >> app/globals.css

cat "import React from 'react'
import './globals.css'

export default function RootLayout({ children }: {
    children: React.ReactNode
}) {
  return (
    <html lang="en">
      <head />
      <body>
        {children}
      </body>
    </html>
  )
}" >> app/layout.tsx

NEW_SCRIPTS='{
  "dev": "next dev",
  "build": "next build",
  "start": "next start",
  "lint": "next lint"
}'

jq --argjson newScripts "$NEW_SCRIPTS" '.scripts = $newScripts' package.json > temp.json && mv temp.json package.json
