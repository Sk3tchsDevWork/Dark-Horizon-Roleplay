import{c as w,R as h,L as u,b as v,r as c,j as e,B as p,G as m,A as d,f as y}from"./index-DQOIXfH8.js";import{T as j}from"./TextInput-B-iyO67X.js";/**
 * @license @tabler/icons-react v3.19.0 - MIT
 *
 * This source code is licensed under the MIT license.
 * See the LICENSE file in the root directory of this source tree.
 */var k=w("outline","arrow-narrow-right","IconArrowNarrowRight",[["path",{d:"M5 12l14 0",key:"svg-0"}],["path",{d:"M15 16l4 -4",key:"svg-1"}],["path",{d:"M15 8l4 4",key:"svg-2"}]]);/**
 * @license @tabler/icons-react v3.19.0 - MIT
 *
 * This source code is licensed under the MIT license.
 * See the LICENSE file in the root directory of this source tree.
 */var b=w("outline","home","IconHome",[["path",{d:"M5 12l-2 0l9 -9l9 9l-2 0",key:"svg-0"}],["path",{d:"M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7",key:"svg-1"}],["path",{d:"M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6",key:"svg-2"}]]);const f="_header_1h767_1",_="_input_1h767_17",g={header:f,input:_},S=({url:t})=>e.jsx("div",{style:{width:"100%",height:"100%",position:"relative"},children:e.jsx("iframe",{allowFullScreen:!1,style:{borderStyle:"none"},height:"92%",width:"100%",src:t,title:"Web Browser",sandbox:"allow-scripts allow-same-origin"})}),M=()=>{const t=h(u),a=h(v),[r,o]=c.useState(a.browser.homepage),[n,i]=c.useState(r),x=()=>{i(a.browser.homepage),o(a.browser.homepage)},l=async()=>{const s=await y("av_laptop","website",n);s&&o(s)};return e.jsxs(p,{style:{height:"100%",width:"100%"},bg:"#1C1C1E",children:[e.jsx(p,{className:g.header,children:e.jsxs(m,{justify:"center",w:"100%",gap:"xs",children:[e.jsx(d,{variant:"transparent",color:"dark.1",size:"xs",onClick:()=>{x()},children:e.jsx(b,{stroke:1.5})}),e.jsx(j,{value:n,placeholder:t.navigate,classNames:g,size:"xs",w:"30%",maw:600,onKeyDown:s=>{s.key==="Enter"&&l()},onChange:s=>{i(s.target.value)},rightSection:e.jsx(d,{variant:"light",color:"dark.1",size:"xs",radius:20,onClick:()=>{l()},children:e.jsx(k,{style:{width:"14px",height:"14px"}})})})]})}),e.jsx(S,{url:r})]})};export{M as default};
