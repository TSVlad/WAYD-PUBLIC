import {keycloak} from "../../components/security/KeycloakSettings";

const clientRequest = (
    path='/',
    method='GET',
    body= null,
    headers={

    },
    url= process.env.GATEWAY_ADDRESS ? process.env.GATEWAY_ADDRESS : 'http://localhost:8080',
) => {
    const request = {
        method: method,
        headers: {
        }
    }

    if (keycloak.authenticated) {
        console.log("adding token")
        request.headers['Authorization'] = `Bearer ${keycloak.token}`
    } else {
        console.log("no auth")
        console.log(keycloak)
    }

    if (method !== 'GET' && method !== 'DELETE' && ((body && body.constructor.name !== 'FormData') || (typeof body == "boolean"))) {
        request.body = JSON.stringify(body)
        request.headers = {
            ...request.headers,
            'Content-Type': 'application/json'
        }
    } else if (body && body.constructor && body && body.constructor.name === 'FormData') {
        request.body = body
    }
    console.log(url + path)
    console.log(request)
    return fetch(url + path, request)
}

export default clientRequest