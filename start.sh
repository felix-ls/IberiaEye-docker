#!/bin/sh 
sed -i "s#http:.*:2000/#${URL}#g" /IberiaEye/src/http/index.ts
npm run dev
