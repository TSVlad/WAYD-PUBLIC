import Keycloak from "keycloak-js";

const keycloak = new Keycloak({
    url: process.env.KEYCLOAK_ADDRESS? process.env.KEYCLOAK_ADDRESS : "http://host.docker.internal:8484/auth",
    realm: 'WAYD',
    clientId: 'wayd-frontend',
})

export {keycloak}