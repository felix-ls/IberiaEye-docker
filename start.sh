#!/bin/sh 
sed -i "s#http:.*:2000/#${URL}#g" /IberiaEye/.env.local
npm i -g npm && npm run dev