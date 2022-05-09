import {Pagination, Row} from "react-bootstrap";
import {useState} from "react";
import {range} from "../../utills/arrays";

const getFirstVisiblePage = (selectedPage) => {
    return selectedPage - 2 > 0 ? selectedPage - 2 : 0
}

const getLastVisiblePage = (selectedPage, pagesNumber) => {
    return selectedPage + 3 < pagesNumber ? selectedPage + 3 : pagesNumber
}

const PaginationComponent = (props) => {
    const [selectedPage, setSelectedPage] = useState(0);

    const updatePage = (page) => {
        setSelectedPage(page)
        if (props.onPageChange) {
            props.onPageChange(page)
        }
    }

    return (
        <Row className={"mt-3 text-center"}>
            <Pagination className={'justify-content-center'}>
                <Pagination.First disabled={selectedPage === 0} onClick={() => {
                    updatePage(0)
                }}/>
                <Pagination.Prev disabled={selectedPage === 0} onClick={() => {
                    if (selectedPage > 0) {
                        updatePage(selectedPage - 1)
                    }
                }}/>
                {
                    selectedPage > 2 && (
                        <Pagination.Ellipsis />
                    )
                }

                { props.pagesNumber &&
                    range(getFirstVisiblePage(selectedPage), getLastVisiblePage(selectedPage, props.pagesNumber))
                        .map(page => (
                            <Pagination.Item key={page} active={page === selectedPage} onClick={() => {
                                updatePage(page)
                            }}>{page + 1}</Pagination.Item>
                    ))
                }


                {
                    selectedPage < props.pagesNumber - 3 && (
                        <Pagination.Ellipsis />
                    )
                }


                <Pagination.Next disabled={selectedPage === props.pagesNumber - 1} onClick={() => {
                    if (selectedPage < props.pagesNumber - 1) {
                        updatePage(selectedPage + 1)
                    }
                }}/>
                <Pagination.Last disabled={selectedPage === props.pagesNumber - 1} onClick={() => {
                    updatePage(props.pagesNumber - 1)
                }}/>
            </Pagination>
        </Row>
    )
}

export default PaginationComponent