FROM node:lts
LABEL coolify-preserve=true

WORKDIR /usr/src/app

RUN curl -f https://get.pnpm.io/v6.js | node - add --global pnpm

COPY ./*package.json .

RUN pnpm install

COPY . .

RUN pnpm build

CMD ["pnpm", "start"]

EXPOSE 3000
