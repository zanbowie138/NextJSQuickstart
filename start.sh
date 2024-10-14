echo "# Logs
logs
*.log
npm-debug.log*

# Runtime data
pids
*.pid
*.seed

# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov

# Coverage directory used by tools like istanbul
coverage

# nyc test coverage
.nyc_output

# Grunt intermediate storage (http://gruntjs.com/creating-plugins#storing-task-files)
.grunt

# node-waf configuration
.lock-wscript

# Compiled binary addons (http://nodejs.org/api/addons.html)
build/Release

# Dependency directories
node_modules
jspm_packages

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history
.next" >> .gitignore

npm install next@latest react@latest react-dom@latest
npm install --save-dev typescript tailwindcss @types/react @types/node
npx tailwind init

echo '{
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

echo "module.exports = {
  plugins: {
    tailwindcss: {},
  },
}" >> postcss.config.js

mkdir app
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" >> app/globals.css

echo "import React from 'react'
import './globals.css'

export default function RootLayout({ children }: {
    children: React.ReactNode
}) {
  return (
    <html lang=\"en\">
      <head />
      <body>
        {children}
      </body>
    </html>
  )
}" >> app/layout.tsx

echo "import React from 'react'

export default function Home() {
    return (
        <div>
            <h1 className=\"text-5xl\">Hello World</h1>
        </div>
    )
}" >> app/page.tsx

NEW_SCRIPTS='},\
 "scripts": {\
     "dev": "next dev",\
     "build": "next build",\
     "start": "next start",\
     "lint": "next lint"\
 },'

sed -i "s|},|$NEW_SCRIPTS|" package.json

NEW_CONTENT='content: ["./app/**/*.{js,ts,jsx,tsx,mdx}",\
        "./components/**/*.{js,ts,jsx,tsx,mdx}"]'
sed -i "s|content: \[\]|$NEW_CONTENT|" tailwind.config.js