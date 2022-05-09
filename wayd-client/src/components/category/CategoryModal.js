import {useEffect, useState} from "react";
import {Button, Form, InputGroup, Modal} from "react-bootstrap";

const CategoryModal = (props) => {
    const categoryMock = {
        categoryName: '',
        subCategories: []
    }

    const [categoryCopy, setCategoryCopy] = useState(!props.category ? categoryMock : JSON.parse(JSON.stringify(props.category)))

    useEffect(() => {
        setCategoryCopy(!props.category ? categoryMock : JSON.parse(JSON.stringify(props.category)))
    }, [props.category])

    const onClose = () => {
        if (!props.category) {
            setCategoryCopy(categoryMock)
        }
        props.onCloseCallback()
    }

    const addEmptySub = () => {
        const newCategory = {
            ...categoryCopy
        }
        newCategory.subCategories.push('')
        setCategoryCopy(newCategory)
    }

    const updateName = (name) => {
        categoryCopy.categoryName = name
        const newCategory = {...categoryCopy}
        newCategory.categoryName = name
        setCategoryCopy(newCategory)
    }

    const updateSubName = (name, index) => {
        const newCategory = {...categoryCopy}
        newCategory.subCategories[index] = name
        setCategoryCopy(newCategory)
    }

    const deleteSub = (index) => {
        console.log(index)
        const newCategory = {...categoryCopy}
        newCategory.subCategories = newCategory.subCategories.filter((val, ind) => index !== ind)
        setCategoryCopy(newCategory)
    }

    return (
        <Modal
            show={props.show}
            backdrop="static"
            keyboard={false}
        >
            <Modal.Header closeButton onClick={props.onCloseCallback}>
                <Modal.Title>Modal title</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Group>
                        <Form.Label>Category name</Form.Label>
                        <Form.Control type="text" placeholder="Category name" value={categoryCopy.categoryName}
                                      onChange={e => {
                                          updateName(e.target.value)
                                      }}/>
                    </Form.Group>
                </Form>
                <Form className="mt-3">
                    {categoryCopy.subCategories.length > 0 &&
                    <Form.Label>Subcategories:</Form.Label>
                    }
                    {categoryCopy.subCategories.map((sub, index) => (
                        <InputGroup className="mt-1" key={index}>
                            <Form.Control type="text" placeholder="Subcategory name" value={sub}
                                          onChange={e => {
                                              updateSubName(e.target.value, index)
                                          }}/>
                            <Button variant="danger" onClick={() => {
                                deleteSub(index)
                            }}>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     className="bi bi-trash-fill" viewBox="0 0 16 16">
                                    <path
                                        d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
                                </svg>
                            </Button>
                        </InputGroup>
                    ))}
                </Form>

                <div className="text-center mt-3">
                    <Button variant="success" onClick={addEmptySub}>Add subcategory</Button>
                </div>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={props.onCloseCallback}>
                    Close
                </Button>
                <Button variant="primary" onClick={() => {
                    props.onSaveCallback(categoryCopy)
                }}>Save</Button>
            </Modal.Footer>
        </Modal>
    )
}

export default CategoryModal