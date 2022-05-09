import EventCardComponent from "./EventCardComponent";
import {Button, Form} from "react-bootstrap";
import {useEffect, useState} from "react";
import {useMap} from "react-leaflet";
import {getAllCategoriesRequest} from "../../../utills/request/requests/requests";
import {isoToLocalDateTime} from "../../../utills/dates";

const modes = {
    OFF: 'OFF',
    SELECTED_EVENT: 'SELECTED_EVENT',
    LIST: 'LIST',
    FILTERS: 'FILTERS'
}

const WindowComponent = (props) => {
    const [mode, setMode] = useState(modes.OFF)
    const [previousMode, setPreviousMode] = useState(modes.OFF)

    const [categories, setCategories] = useState({})

    const [filter, setFilter] = useState({
        category: null,
        subcategory: null,
        dateAfter: null,
        dateBefore: null
    })

    const map = useMap()

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
            setCategories(categoriesMap)
        }).catch(errorCode => {

        })
    }, [])

    useEffect(() => {
        if (!!props.selectedEvent) {
            if (mode !== modes.SELECTED_EVENT) {
                setPreviousMode(mode)
            }
            setMode(modes.SELECTED_EVENT)
        } else {
            setMode(previousMode)
            setPreviousMode(modes.OFF)
        }
    }, [props.selectedEvent])

    const getWindowContent = () => {
        switch (mode) {
            case modes.SELECTED_EVENT:
                return (
                    <>
                        {props.selectedEvent && (
                            <EventCardComponent event={props.selectedEvent}
                                                imageUrl={(props.selectedEvent.picturesRefs.length > 0)
                                                    ? props.imageMap[props.selectedEvent.picturesRefs[0]]
                                                    : null}/>
                        )}
                    </>
                );
            case modes.LIST:
                return (
                    <>
                        {props.events && props.events.map(event => (
                            <EventCardComponent event={event}
                                                imageUrl={(event.picturesRefs.length > 0)
                                                    ? props.imageMap[event.picturesRefs[0]]
                                                    : null}/>
                        ))}
                    </>
                )
            case modes.FILTERS:
                return (
                    <div className={'text-left m-3'} style={{width: '14rem'}}>
                        <Form>
                            <Form.Group className={'mt-2'}>
                                <Form.Label>Category</Form.Label>
                                <Form.Select onChange={e => {
                                    console.log(e.target.value)
                                    setFilter({...filter, category: e.target.value || null})
                                }}>
                                    <option value=''>-</option>
                                    {Object.values(categories).map(category => (
                                        <option key={category.categoryName}
                                                selected={filter.category === category.categoryName}
                                                value={category.categoryName}>{category.categoryName}</option>
                                    ))}
                                </Form.Select>
                            </Form.Group>

                            <Form.Group className={'mt-2'}>
                                <Form.Label>Subcategory</Form.Label>
                                <Form.Select
                                    disabled={!filter.category || categories[filter.category].subCategories.length === 0}
                                    onChange={e => {
                                        setFilter({...filter, subcategory: e.target.value || null})
                                    }}>
                                    <option value=''>-</option>
                                    {!!filter.category && !!categories[filter.category] && categories[filter.category].subCategories.map(sub => (
                                        <option key={sub} selected={filter.subcategory === sub} value={sub}>{sub}</option>
                                    ))}
                                </Form.Select>
                            </Form.Group>

                            <Form.Group className={'mt-2'}>
                                <Form.Label>Date after</Form.Label>
                                <Form.Control type={'datetime-local'}
                                              value={isoToLocalDateTime(filter.dateAfter)}
                                              onChange={(e) => {
                                                  setFilter({
                                                      ...filter,
                                                      dateAfter: !!e.target.value ? new Date(e.target.value).toISOString() : null
                                                  })
                                              }}/>
                            </Form.Group>

                            <Form.Group className={'mt-2'}>
                                <Form.Label>Date before</Form.Label>
                                <Form.Control type={'datetime-local'} value={isoToLocalDateTime(filter.dateBefore)}
                                              onChange={(e) => {
                                    setFilter({...filter, dateBefore: new Date(e.target.value).toISOString()})
                                }}/>
                            </Form.Group>


                            <Form.Group className={'mt-3 text-center'}>
                                <Button onClick={() => {
                                    props.applyFilter(filter)
                                }}>Apply filter</Button>
                            </Form.Group>

                        </Form>
                    </div>
                )
            default:
                return null
        }
    }

    return (
        <div id={'window-component'} style={{cursor: 'default'}} className={'text-right'}
             onMouseLeave={() => map.scrollWheelZoom.enable()} onMouseEnter={() => map.scrollWheelZoom.disable()}>
            <Button variant={mode === modes.FILTERS ? 'dark' : 'light'} onClick={() => {
                if (mode !== modes.FILTERS) {
                    setPreviousMode(mode)
                    setMode(modes.FILTERS)
                } else {
                    setMode(previousMode)
                    setPreviousMode(modes.OFF)
                }
            }}>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     className="bi bi-funnel-fill" viewBox="0 0 16 16">
                    <path
                        d="M1.5 1.5A.5.5 0 0 1 2 1h12a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.128.334L10 8.692V13.5a.5.5 0 0 1-.342.474l-3 1A.5.5 0 0 1 6 14.5V8.692L1.628 3.834A.5.5 0 0 1 1.5 3.5v-2z"/>
                </svg>
            </Button>
            <Button variant={mode === modes.LIST || previousMode === modes.LIST ? 'dark' : 'light'} onClick={() => {
                if (mode === modes.LIST) {
                    setMode(modes.OFF)
                } else {
                    setMode(modes.LIST)
                }
            }}>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     className="bi bi-list-ul" viewBox="0 0 16 16">
                    <path fillRule="evenodd"
                          d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm-3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                </svg>
            </Button>

            {mode !== modes.OFF && (
                <div className={'window-scrolling mt-3 mb-3'}>
                    {getWindowContent()}
                </div>
            )}

        </div>
    )
}

export default WindowComponent