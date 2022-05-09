import {useEffect, useState} from "react";
import {useKeycloak} from "@react-keycloak/web";
import {
    createBanWordRequest,
    deleteBanWordRequest,
    getBanWordsRequest
} from "../../utills/request/requests/validatorRequest";
import BanWordItemComponent from "./BanWordItemComponent";
import {Button, Form, FormControl} from "react-bootstrap";

const BanWordsComponent = (props) => {

    const [words, setWords] = useState([])
    const [search, setSearch] = useState('')
    const [addedWords, setAddedWords] = useState('')
    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
            getBanWordsRequest()
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(words => {
                    console.log(words)
                    setWords(words)
                })
        }
    }, [initialized])

    return (
        <div className={props.className}>
            <Form className="d-flex">
                <FormControl
                    type="search"
                    placeholder="Search"
                    className="me-2"
                    aria-label="Search"
                    onChange={(e) => {
                        setSearch(e.target.value)
                    }}
                />
            </Form>
            <Form className="d-flex mt-3 justify-content-center">
                <FormControl className={'w-50'} onChange={e => {
                    setAddedWords(e.target.value)
                }}/>
                <Button variant={'success'} onClick={() => {
                    createBanWordRequest(addedWords)
                        .then(response => {
                            if (response.status === 200) {
                                return response.json()
                            } else {
                                throw response
                            }
                        })
                        .then(newWords => {
                            setWords([...words, ...newWords])
                        })
                }}>Add</Button>
            </Form>
            <h2 className={'mt-3'}>
                {words.filter(word => word.word.startsWith(search)).map((word, index) => (<BanWordItemComponent key={word.id} word={word.word} className={'ml-2 mt-2'} onDelete={() => {
                    deleteBanWordRequest(word.id)
                        .then(response => {
                            if (response.status === 200) {
                                const newArr = [...words]
                                newArr.splice(index, 1)
                                setWords(newArr)
                            }
                        })
                }}/>))}
            </h2>
        </div>
    )
}

export default BanWordsComponent