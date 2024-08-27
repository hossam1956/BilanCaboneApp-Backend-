<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        /* TailwindCSS v3.4.6 | MIT License | https://tailwindcss.com */
        
        *,
        ::before,
        ::after {
          box-sizing: border-box;
          border-width: 0;
          border-style: solid;
          border-color: #e5e7eb;
        }

        ::before,
        ::after {
          --tw-content: '';
        }

        html,
        :host {
          line-height: 1.5;
          -webkit-text-size-adjust: 100%;
          -moz-tab-size: 4;
          -o-tab-size: 4;
             tab-size: 4;
          font-family: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
          font-feature-settings: normal;
          font-variation-settings: normal;
          -webkit-tap-highlight-color: transparent;
        }

        body {
          margin: 0;
          line-height: inherit;
        }

        hr {
          height: 0;
          color: inherit;
          border-top-width: 1px;
        }

        abbr:where([title]) {
          -webkit-text-decoration: underline dotted;
                  text-decoration: underline dotted;
        }

        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
          font-size: inherit;
          font-weight: inherit;
        }

        a {
          color: inherit;
          text-decoration: inherit;
        }

        b,
        strong {
          font-weight: bolder;
        }

        code,
        kbd,
        samp,
        pre {
          font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
          font-feature-settings: normal;
          font-variation-settings: normal;
          font-size: 1em;
        }

        small {
          font-size: 80%;
        }

        sub,
        sup {
          font-size: 75%;
          line-height: 0;
          position: relative;
          vertical-align: baseline;
        }

        sub {
          bottom: -0.25em;
        }

        sup {
          top: -0.5em;
        }

        table {
          text-indent: 0;
          border-color: inherit;
          border-collapse: collapse;
        }

        button,
        input,
        optgroup,
        select,
        textarea {
          font-family: inherit;
          font-feature-settings: inherit;
          font-variation-settings: inherit;
          font-size: 100%;
          font-weight: inherit;
          line-height: inherit;
          letter-spacing: inherit;
          color: inherit;
          margin: 0;
          padding: 0;
        }

        button,
        select {
          text-transform: none;
        }

        button,
        input:where([type='button']),
        input:where([type='reset']),
        input:where([type='submit']) {
          -webkit-appearance: button;
          background-color: transparent;
          background-image: none;
        }

        :-moz-focusring {
          outline: auto;
        }

        :-moz-ui-invalid {
          box-shadow: none;
        }

        progress {
          vertical-align: baseline;
        }

        ::-webkit-inner-spin-button,
        ::-webkit-outer-spin-button {
          height: auto;
        }

        [type='search'] {
          -webkit-appearance: textfield;
          outline-offset: -2px;
        }

        ::-webkit-search-decoration {
          -webkit-appearance: none;
        }

        ::-webkit-file-upload-button {
          -webkit-appearance: button;
          font: inherit;
        }

        summary {
          display: list-item;
        }

        blockquote,
        dl,
        dd,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        hr,
        figure,
        p,
        pre {
          margin: 0;
        }

        fieldset {
          margin: 0;
          padding: 0;
        }

        legend {
          padding: 0;
        }

        ol,
        ul,
        menu {
          list-style: none;
          margin: 0;
          padding: 0;
        }

        dialog {
          padding: 0;
        }

        textarea {
          resize: vertical;
        }

        input::-moz-placeholder,
        textarea::-moz-placeholder {
          opacity: 1;
          color: #9ca3af;
        }

        input::placeholder,
        textarea::placeholder {
          opacity: 1;
          color: #9ca3af;
        }

        button,
        [role="button"] {
          cursor: pointer;
        }

        :disabled {
          cursor: default;
        }

        img,
        svg,
        video,
        canvas,
        audio,
        iframe,
        embed,
        object {
          display: block;
          vertical-align: middle;
        }

        img,
        video {
          max-width: 100%;
          height: auto;
        }

        [hidden] {
          display: none;
        }

        *, ::before, ::after {
          --tw-border-spacing-x: 0;
          --tw-border-spacing-y: 0;
          --tw-translate-x: 0;
          --tw-translate-y: 0;
          --tw-rotate: 0;
          --tw-skew-x: 0;
          --tw-skew-y: 0;
          --tw-scale-x: 1;
          --tw-scale-y: 1;
          --tw-pan-x:  ;
          --tw-pan-y:  ;
          --tw-pinch-zoom:  ;
          --tw-scroll-snap-strictness: proximity;
          --tw-gradient-from-position:  ;
          --tw-gradient-via-position:  ;
          --tw-gradient-to-position:  ;
          --tw-ordinal:  ;
          --tw-slashed-zero:  ;
          --tw-numeric-figure:  ;
          --tw-numeric-spacing:  ;
          --tw-numeric-fraction:  ;
          --tw-ring-inset:  ;
          --tw-ring-offset-width: 0px;
          --tw-ring-offset-color: #fff;
          --tw-ring-color: rgb(59 130 246 / 0.5);
          --tw-ring-offset-shadow: 0 0 #0000;
          --tw-ring-shadow: 0 0 #0000;
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          --tw-blur:  ;
          --tw-brightness:  ;
          --tw-contrast:  ;
          --tw-grayscale:  ;
          --tw-hue-rotate:  ;
          --tw-invert:  ;
          --tw-saturate:  ;
          --tw-sepia:  ;
          --tw-drop-shadow:  ;
          --tw-backdrop-blur:  ;
          --tw-backdrop-brightness:  ;
          --tw-backdrop-contrast:  ;
          --tw-backdrop-grayscale:  ;
          --tw-backdrop-hue-rotate:  ;
          --tw-backdrop-invert:  ;
          --tw-backdrop-opacity:  ;
          --tw-backdrop-saturate:  ;
          --tw-backdrop-sepia:  ;
          --tw-contain-size:  ;
          --tw-contain-layout:  ;
          --tw-contain-paint:  ;
          --tw-contain-style:  ;
        }

        ::backdrop {
          --tw-border-spacing-x: 0;
          --tw-border-spacing-y: 0;
          --tw-translate-x: 0;
          --tw-translate-y: 0;
          --tw-rotate: 0;
          --tw-skew-x: 0;
          --tw-skew-y: 0;
          --tw-scale-x: 1;
          --tw-scale-y: 1;
          --tw-pan-x:  ;
          --tw-pan-y:  ;
          --tw-pinch-zoom:  ;
          --tw-scroll-snap-strictness: proximity;
          --tw-gradient-from-position:  ;
          --tw-gradient-via-position:  ;
          --tw-gradient-to-position:  ;
          --tw-ordinal:  ;
          --tw-slashed-zero:  ;
          --tw-numeric-figure:  ;
          --tw-numeric-spacing:  ;
          --tw-numeric-fraction:  ;
          --tw-ring-inset:  ;
          --tw-ring-offset-width: 0px;
          --tw-ring-offset-color: #fff;
          --tw-ring-color: rgb(59 130 246 / 0.5);
          --tw-ring-offset-shadow: 0 0 #0000;
          --tw-ring-shadow: 0 0 #0000;
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          --tw-blur:  ;
          --tw-brightness:  ;
          --tw-contrast:  ;
          --tw-grayscale:  ;
          --tw-hue-rotate:  ;
          --tw-invert:  ;
          --tw-saturate:  ;
          --tw-sepia:  ;
          --tw-drop-shadow:  ;
          --tw-backdrop-blur:  ;
          --tw-backdrop-brightness:  ;
          --tw-backdrop-contrast:  ;
          --tw-backdrop-grayscale:  ;
          --tw-backdrop-hue-rotate:  ;
          --tw-backdrop-invert:  ;
          --tw-backdrop-opacity:  ;
          --tw-backdrop-saturate:  ;
          --tw-backdrop-sepia:  ;
          --tw-contain-size:  ;
          --tw-contain-layout:  ;
          --tw-contain-paint:  ;
          --tw-contain-style:  ;
        }

        :root {
          -moz-tab-size: 4;
          -o-tab-size: 4;
             tab-size: 4;
          --tw-bg-opacity: 1;
          --tw-text-opacity: 1;
          --tw-border-opacity: 1;
        }

        body {
          font-family: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        }

        .fixed {
          position: fixed;
        }

        .inset-0 {
          top: 0px;
          right: 0px;
          bottom: 0px;
          left: 0px;
        }

        .h-full {
          height: 100%;
        }

        .min-h-screen {
          min-height: 100vh;
        }

        .overflow-hidden {
          overflow: hidden;
        }

        .bg-cover {
          background-size: cover;
        }

        .bg-center {
          background-position: center;
        }

        .container {
          width: 100%;
        }

        @media (min-width: 640px) {
          .container {
            max-width: 640px;
          }
        }

        @media (min-width: 768px) {
          .container {
            max-width: 768px;
          }
        }

        @media (min-width: 1024px) {
          .container {
            max-width: 1024px;
          }
        }

        @media (min-width: 1280px) {
          .container {
            max-width: 1280px;
          }
        }

        @media (min-width: 1536px) {
          .container {
            max-width: 1536px;
          }
        }

        .mx-auto {
          margin-left: auto;
          margin-right: auto;
        }

        .grid {
          display: grid;
        }

        .place-content-center {
          place-content: center;
        }

        .gap-10 {
          gap: 2.5rem;
        }

        .px-6 {
          padding-left: 1.5rem;
          padding-right: 1.5rem;
        }

        .pb-8 {
          padding-bottom: 2rem;
        }

        .pt-10 {
          padding-top: 2.5rem;
        }

        @media (min-width: 768px) {
          .pt-10\:lg {
            padding-top: 2.5rem;
          }
        }

        .text-center {
          text-align: center;
        }

        .text-white {
          --tw-text-opacity: 1;
          color: rgb(255 255 255 / var(--tw-text-opacity));
        }

        .text-2xl {
          font-size: 1.5rem;
          line-height: 2rem;
        }

        @media (min-width: 1024px) {
          .text-2xl\:lg {
            font-size: 1.5rem;
            line-height: 2rem;
          }
        }

        .font-light {
          font-weight: 300;
        }

        .leading-snug {
          line-height: 1.375;
        }

        .w-full {
          width: 100%;
        }

        .flex {
          display: flex;
        }

        .rounded {
          border-radius: 0.25rem;
        }

        .bg-transparent {
          background-color: transparent;
        }

        .px-4 {
          padding-left: 1rem;
          padding-right: 1rem;
        }

        .py-2 {
          padding-top: 0.5rem;
          padding-bottom: 0.5rem;
        }

        .text-gray-400 {
          --tw-text-opacity: 1;
          color: rgb(156 163 175 / var(--tw-text-opacity));
        }

        .focus\:outline-none:focus {
          outline: 2px solid transparent;
          outline-offset: 2px;
        }

        .border {
          border-width: 1px;
        }

        .border-gray-300 {
          --tw-border-opacity: 1;
          border-color: rgb(209 213 219 / var(--tw-border-opacity));
        }

        .focus\:ring-primary:focus {
          --tw-ring-color: var(--primary);
          --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
          --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);
        }

        .focus\:border-primary:focus {
          border-color: var(--primary);
        }

        .hover\:bg-primary:hover {
          background-color: var(--primary);
        }

        .bg-primary {
          background-color: var(--primary);
        }

        .mt-8 {
          margin-top: 2rem;
        }

        .items-center {
          align-items: center;
        }

        .justify-center {
          justify-content: center;
        }

        .relative {
          position: relative;
        }

        .inline-block {
          display: inline-block;
        }

        .outline-none {
          outline: 2px solid transparent;
          outline-offset: 2px;
        }

        .focus\:ring-secondary:focus {
          --tw-ring-color: var(--secondary);
          --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
          --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);
        }

        .focus\:border-secondary:focus {
          border-color: var(--secondary);
        }

        .hover\:bg-secondary:hover {
          background-color: var(--secondary);
        }

        .bg-secondary {
          background-color: var(--secondary);
        }

        .focus\:ring-tertiary:focus {
          --tw-ring-color: var(--tertiary);
          --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
          --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);
        }

        .focus\:border-tertiary:focus {
          border-color: var(--tertiary);
        }

        .hover\:bg-tertiary:hover {
          background-color: var(--tertiary);
        }

        .bg-tertiary {
          background-color: var(--tertiary);
        }

        .focus\:ring-quaternary:focus {
          --tw-ring-color: var(--quaternary);
          --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
          --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);
        }

        .focus\:border-quaternary:focus {
          border-color: var(--quaternary);
        }

        .hover\:bg-quaternary:hover {
          background-color: var(--quaternary);
        }

        .bg-quaternary {
          background-color: var(--quaternary);
        }

        .duration-200 {
          transition-duration: 200ms;
        }

        .transition-all {
          transition-property: all;
        }

        .max-w-500px {
          max-width: 500px;
        }

        .max-w-900px {
          max-width: 900px;
        }

        .-rotate-12 {
          --tw-rotate: -12deg;
          transform: rotate(var(--tw-rotate));
        }

        .rotate-12 {
          --tw-rotate: 12deg;
          transform: rotate(var(--tw-rotate));
        }

        .absolute {
          position: absolute;
        }

        .bottom-0 {
          bottom: 0px;
        }

        .hidden {
          display: none;
        }

        @media (min-width: 1024px) {
          .block\:lg {
            display: block;
          }
        }

        .-translate-x-1/2 {
          --tw-translate-x: -50%;
          transform: translateX(var(--tw-translate-x)) translateY(var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
        }

        .left-1/2 {
          left: 50%;
        }

        .pb-20 {
          padding-bottom: 5rem;
        }

        .left-0 {
          left: 0px;
        }

        .right-0 {
          right: 0px;
        }

        .pointer-events-none {
          pointer-events: none;
        }

        .top-20 {
          top: 5rem;
        }

        @media (min-width: 768px) {
          .top-20\:lg {
            top: 5rem;
          }
        }

        .bottom-4 {
          bottom: 1rem;
        }

        @media (min-width: 768px) {
          .bottom-4\:lg {
            bottom: 1rem;
          }
        }

        .inline-flex {
          display: inline-flex;
        }

        .mr-2 {
          margin-right: 0.5rem;
        }

        .uppercase {
          text-transform: uppercase;
        }

        .text-base {
          font-size: 1rem;
          line-height: 1.5rem;
        }

        @media (min-width: 1024px) {
          .text-base\:lg {
            font-size: 1rem;
            line-height: 1.5rem;
          }
        }

        .font-semibold {
          font-weight: 600;
        }

        .relative {
          position: relative;
        }

        .align-bottom {
          vertical-align: bottom;
        }

        .align-middle {
          vertical-align: middle;
        }

        .align-top {
          vertical-align: top;
        }

        .self-center {
          align-self: center;
        }

        .content-end {
          align-content: end;
        }

        .content-start {
          align-content: start;
        }

        .content-center {
          align-content: center;
        }

        .grid-flow-col {
          grid-auto-flow: column;
        }

        .grid-flow-row {
          grid-auto-flow: row;
        }

        .grid-cols-2 {
          grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .grid-cols-3 {
          grid-template-columns: repeat(3, minmax(0, 1fr));
        }

        .grid-cols-4 {
          grid-template-columns: repeat(4, minmax(0, 1fr));
        }

        .grid-rows-1 {
          grid-template-rows: repeat(1, minmax(0, 1fr));
        }

        .grid-rows-2 {
          grid-template-rows: repeat(2, minmax(0, 1fr));
        }

        .grid-rows-3 {
          grid-template-rows: repeat(3, minmax(0, 1fr));
        }

        .grid-rows-4 {
          grid-template-rows: repeat(4, minmax(0, 1fr));
        }

        .grow {
          flex-grow: 1;
        }

        .h-12 {
          height: 3rem;
        }

        .h-14 {
          height: 3.5rem;
        }

        .h-16 {
          height: 4rem;
        }

        .h-24 {
          height: 6rem;
        }

        .h-28 {
          height: 7rem;
        }

        .h-32 {
          height: 8rem;
        }

        .max-h-28 {
          max-height: 7rem;
        }

        .max-h-32 {
          max-height: 8rem;
        }

        .max-h-48 {
          max-height: 12rem;
        }

        .max-h-60 {
          max-height: 15rem;
        }

        .max-h-64 {
          max-height: 16rem;
        }

        .max-h-80 {
          max-height: 20rem;
        }

        .max-h-96 {
          max-height: 24rem;
        }

        .min-h-32 {
          min-height: 8rem;
        }

        .min-h-60 {
          min-height: 15rem;
        }

        .min-h-64 {
          min-height: 16rem;
        }

        .min-h-80 {
          min-height: 20rem;
        }

        .min-h-96 {
          min-height: 24rem;
        }

        .h-auto {
          height: auto;
        }

        .h-screen {
          height: 100vh;
        }

        .w-12 {
          width: 3rem;
        }

        .w-14 {
          width: 3.5rem;
        }

        .w-16 {
          width: 4rem;
        }

        .w-20 {
          width: 5rem;
        }

        .w-24 {
          width: 6rem;
        }

        .w-28 {
          width: 7rem;
        }

        .w-32 {
          width: 8rem;
        }

        .w-36 {
          width: 9rem;
        }

        .max-w-32 {
          max-width: 8rem;
        }

        .max-w-40 {
          max-width: 10rem;
        }

        .max-w-48 {
          max-width: 12rem;
        }

        .max-w-60 {
          max-width: 15rem;
        }

        .max-w-72 {
          max-width: 18rem;
        }

        .max-w-80 {
          max-width: 20rem;
        }

        .min-w-32 {
          min-width: 8rem;
        }

        .min-w-60 {
          min-width: 15rem;
        }

        .min-w-80 {
          min-width: 20rem;
        }

        .min-w-96 {
          min-width: 24rem;
        }

        .w-auto {
          width: auto;
        }

        .w-screen {
          width: 100vw;
        }

        .w-fit-content {
          width: -moz-fit-content;
          width: fit-content;
        }

        .z-10 {
          z-index: 10;
        }

        .z-20 {
          z-index: 20;
        }

        .z-30 {
          z-index: 30;
        }

        .rounded-lg {
          border-radius: 0.5rem;
        }

        .rounded-full {
          border-radius: 9999px;
        }

        .border-solid {
          border-style: solid;
        }

        .border-dashed {
          border-style: dashed;
        }

        .border-double {
          border-style: double;
        }

        .border-none {
          border-style: none;
        }

        .border-2 {
          border-width: 2px;
        }

        .border-4 {
          border-width: 4px;
        }

        .border-8 {
          border-width: 8px;
        }

        .border-t-2 {
          border-top-width: 2px;
        }

        .border-b-2 {
          border-bottom-width: 2px;
        }

        .border-l-2 {
          border-left-width: 2px;
        }

        .border-r-2 {
          border-right-width: 2px;
        }

        .text-right {
          text-align: right;
        }

        .text-left {
          text-align: left;
        }

        .capitalize {
          text-transform: capitalize;
        }

        .lowercase {
          text-transform: lowercase;
        }

        .no-underline {
          text-decoration: none;
        }

        .underline {
          text-decoration: underline;
        }

        .underline-on-hover:hover {
          text-decoration: underline;
        }

        .no-underline-on-hover:hover {
          text-decoration: none;
        }

        .line-through {
          text-decoration: line-through;
        }

        .animate-pulse {
          animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }

        @keyframes pulse {
          0%, 100% {
            opacity: 1;
          }

          50% {
            opacity: .5;
          }
        }

        .animate-bounce {
          animation: bounce 1s infinite;
        }

        @keyframes bounce {
          0%, 100% {
            transform: translateY(-25%);
            animation-timing-function: cubic-bezier(0.8,0,1,1);
          }

          50% {
            transform: translateY(0);
            animation-timing-function: cubic-bezier(0,0,0.2,1);
          }
        }

        .animate-ping {
          animation: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite;
        }

        @keyframes ping {
          0% {
            transform: scale(1);
            opacity: 1;
          }

          75%, 100% {
            transform: scale(2);
            opacity: 0;
          }
        }

        .animate-spin {
          animation: spin 1s linear infinite;
        }

        @keyframes spin {
          to {
            transform: rotate(360deg);
          }
        }

        .animate-none {
          animation: none;
        }
    </style>
  </head>

  <body class="bg-red-500">

    <div class="container mx-auto px-6 pt">

        <p class="text-gray-500">Please login to continue.</p>
        <form action="${url.loginAction}" method="post">
            <input type="text" name="username" placeholder="Username" class="input-class">
            <input type="password" name="password" placeholder="Password" class="input-class">
            <button type="submit" class="btn-class">Login</button>
        </form>
    </div>
</body>
</html>
