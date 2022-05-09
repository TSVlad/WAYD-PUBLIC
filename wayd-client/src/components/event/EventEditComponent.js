import {Button, Form, Image, Row} from "react-bootstrap";
import {useEffect, useRef, useState} from "react";
import {
    getAllCategoriesRequest,
    getImageUrlsByIdsRequest, saveEventRequest,
    uploadImagesRequest
} from "../../utills/request/requests/requests";
import SmallMapComponent from "../map/SmallMapComponent";
import '../../css/image.css'
import {useHistory} from "react-router-dom";
import {isoToLocalDateTime} from "../../utills/dates";

const EventEditComponent = (props) => {
    const [event, setEvent] = useState(props.event ? props.event : {
        name: '',
        description: '',
        contacts: '',
        category: null,
        subCategory: null,
        dateTime: null,

        point: null,
        picturesRefs: [],

        minNumberOfParticipants: 0,
        maxNumberOfParticipants: 0,
        minAge: 0,
        maxAge: 0,
        deadline: null
    })
    const [categories, setCategories] = useState({})
    const [imagesURLs, setImagesURLs] = useState([])
    const inputRef = useRef(null)
    const history = useHistory()

    useEffect(() => {
        getAllCategoriesRequest().then(response => {
            if (response.status === 200) {
                return response.json()
            } else {
                throw response.status
            }
        }).then(categoriesResponse => {
            const categoriesMap = {}
            for (const category of categoriesResponse) {
                categoriesMap[category.categoryName] = category
            }
            if (event.category && !categoriesMap[event.category]) {
                categoriesMap[event.category] = {
                    categoryName: event.category,
                    subCategories: event.subCategory ? [event.subCategory] : []
                }
            } else if (event.subCategory && !categoriesMap[event.category].subCategories.includes(event.subCategory)) {
                categoriesMap[event.category].subCategories.push(event.subCategory)
            }
            setCategories(categoriesMap)
        }).catch(errorCode => {

        })
    }, [])

    useEffect(() => {
        if (props.event) {
            console.log('EVENT')
            console.log(new Date(props.event.dateTime).toISOString())
            console.log(new Date(props.event.dateTime))
            setEvent(props.event)
        }
    }, [props.event])

    useEffect(() => {
        if (event.picturesRefs) {
            getImageUrlsByIdsRequest(event.picturesRefs, true)
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response.status
                    }
                })
                .then(images => {
                    setImagesURLs(images.map(image => image.url))
                })
        }
    }, [event.picturesRefs])

    const uploadImages = (files) => {
        if (files.length <= 0) return
        if (!event.picturesRefs) {
            event.picturesRefs = []
        }
        uploadImagesRequest(files)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response.status
                }
            })
            .then(imagesIds => {
                setEvent({
                    ...event,
                    picturesRefs: [...event.picturesRefs, ...imagesIds]
                })
            })
            .catch(errorCode => {
                console.log('ERROR')
                console.log(errorCode)
            })
    }

    return (
        <div>
            <Form>
                <h2 className="mt-3">General info</h2>
                <Form.Group className="mt-3">
                    <Form.Label>Event name</Form.Label>
                    <Form.Control type="text" placeholder="Event name" value={event.name} onChange={e => {
                        setEvent({...event, name: e.target.value})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Event description</Form.Label>
                    <Form.Control as="textarea" rows={7} value={event.description} placeholder="Event description" onChange={e => {
                        setEvent({...event, description: e.target.value})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Contacts</Form.Label>
                    <Form.Control as="textarea" rows={2} value={event.contacts} placeholder="Contacts" onChange={e => {
                        setEvent({...event, contacts: e.target.value})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Event category</Form.Label>
                    <Form.Select onChange={e => {
                        const category = e.target.value ? JSON.parse(e.target.value) : {}
                        setEvent({...event, category: category.categoryName, subCategory: null})
                    }}>
                        <option value=''>-</option>
                        {Object.values(categories).map(category => (
                            <option value={JSON.stringify(category)} selected={event.category === category.categoryName}>{category.categoryName}</option>
                        ))}
                    </Form.Select>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Event subcategory</Form.Label>
                    <Form.Select disabled={!event.category || !categories[event.category] || categories[event.category].subCategories.length === 0} onChange={e => {
                        setEvent({...event, subCategory: e.target.value})
                    }}>
                        <option value={null}>-</option>
                        {event.category && categories[event.category] && categories[event.category].subCategories.map(sub => (
                            <option value={sub} selected={sub === event.subCategory}>{sub}</option>
                        ))}
                    </Form.Select>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Event date and time</Form.Label>
                    <Form.Control type="datetime-local" value={event.dateTime ? isoToLocalDateTime(event.dateTime) : ''} onChange={e => {
                        setEvent({...event, dateTime: new Date(e.target.value).toISOString()})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Location</Form.Label>
                    <SmallMapComponent markerPosition={event && event.point ? event.point.coordinates : null} editMode={true} onMarkerSet={(latlng) => {
                        setEvent({
                            ...event,
                            point: {
                                type: 'Point',
                                coordinates: [latlng.lat, latlng.lng]
                            }
                        })
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    {imagesURLs && imagesURLs.map((url, index) => (
                        <div key={url} className="image-div mr-1" style={{display: "inline-block"}}>
                            <Image src={url} className="small-image"/>
                            <Button variant="danger" className="delete-image-btn" onClick={() => {
                                const eventCopy = {
                                    ...event,
                                }
                                eventCopy.picturesRefs.splice(index, 1)
                                setEvent(eventCopy)

                                const urlsCopy = [...imagesURLs]
                                urlsCopy.splice(index, 1)
                                setImagesURLs(urlsCopy)
                            }}>-</Button>
                        </div>

                    ))}

                    <div className="image-div" style={{display: "inline-block"}}>
                        <Form.Control className="d-none" type="file" ref={inputRef} accept=".png, .jpg, .jpeg" multiple onChange={e => {
                            uploadImages(e.target.files)
                        }}/>
                        <Button variant={"secondary"} className={"add-image-btn"} onClick={() => {
                            inputRef.current?.click()
                        }}>Add picture</Button>
                    </div>

                </Form.Group>

                <h2 className="mt-3">Requirements for participants</h2>

                <Form.Group className="mt-3">
                    <Form.Label>Minimal number of participants</Form.Label>
                    <Form.Control type="number" defaultValue={0} value={event.minNumberOfParticipants} onChange={e => {
                        setEvent({...event, minNumberOfParticipants: parseInt(e.target.value)})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Maximal number of participants</Form.Label>
                    <Form.Control type="number" defaultValue={0} value={event.maxNumberOfParticipants} onChange={e => {
                        setEvent({...event, maxNumberOfParticipants: parseInt(e.target.value)})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Minimal age of participant</Form.Label>
                    <Form.Control type="number" defaultValue={0} value={event.minAge} onChange={e => {
                        setEvent({...event, minAge: parseInt(e.target.value)})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Maximal age of participant</Form.Label>
                    <Form.Control type="number" defaultValue={0} value={event.maxAge} onChange={e => {
                        setEvent({...event, maxAge: parseInt(e.target.value)})
                    }}/>
                </Form.Group>

                <Form.Group className="mt-3">
                    <Form.Label>Deadline</Form.Label>
                    <Form.Control type="datetime-local" value={event.deadline ? isoToLocalDateTime(event.deadline) : ''} onChange={e => {
                        setEvent({...event, deadline: new Date(e.target.value).toISOString()})
                    }}/>
                </Form.Group>

                <Row className="justify-content-center mt-3">
                    <Button onClick={() => {
                        saveEventRequest(event)
                            .then(response => {
                                if (response.status === 200) {
                                    return response.json()
                                } else {
                                    throw response
                                }
                            })
                            .then(event => {
                                history.push(`/event/${event.id}`)
                            })
                    }}>Save</Button>
                </Row>
            </Form>
        </div>
    )
}

export default EventEditComponent