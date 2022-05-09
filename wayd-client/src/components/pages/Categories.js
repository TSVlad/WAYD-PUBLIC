import {useEffect, useState} from "react";
import clientRequest from "../../utills/request/clientRequest";
import PATHS from "../../utills/constants/servicesPaths";
import CategoryModal from "../category/CategoryModal";

const Categories = () => {
    const [categories, setCategories] = useState([])
    const [categoryInFocus, setCategoryInFocus] = useState(null)
    const [showCategoryModal, setShowCategoryModal] = useState(false)

    useEffect(() => {
        clientRequest(`${PATHS.eventServiceAPI}/event-category`)
            .then(response => response.json())
            .then(categories => {
                console.log(categories)
                setCategories(categories)
            })
    }, [])


    const subCategoriesList = (subcategories) => {
        let result = '';
        for (const sub of subcategories) {
            result += `${sub}, `
        }
        result = result.substring(0, result.length - 2)
        return result;
    }


    const onDelete = (id, index) => {
        console.log(index)
        clientRequest(`${PATHS.eventServiceAPI}/event-category/${id}`, 'DELETE')
            .then(response => {
                if (response.status === 200) {
                    setCategories(categories.filter(category => category.id !== id))
                }
            })
    }

    const onCloseModal = () => {
        setShowCategoryModal(false)
        setCategoryInFocus(null)
    }

    const onAddCategory = () => {
        setCategoryInFocus(null)
        setShowCategoryModal(true)
    }

    const onEditCategory = (category) => {
        setCategoryInFocus(category)
        setShowCategoryModal(true)
    }

    const onSave = (category) => {
        const isNew = !category.id
        clientRequest(`${PATHS.eventServiceAPI}/event-category`, 'POST', category)
            .then(response => {
                if (response.status === 200) {
                    response.json()
                        .then(categoryResponse => {
                            if (isNew) {
                                const newCategories = [...categories]
                                newCategories.push(categoryResponse)
                                setCategories(newCategories)
                            } else {
                                const newCategories = categories.filter(c => c.id !== category.id)
                                newCategories.push(categoryResponse)
                                setCategories(newCategories)
                                setShowCategoryModal(false)
                            }
                        })
                }
            })
    }

    return (
        <div className="container-fluid main-container">
            <div className="row category-row">
                <div className="col-2"/>
                <div className="col-8">
                    <table className="table table-striped table-dark mt-5">
                        <thead>
                        <tr>
                            <th scope="col">Category</th>
                            <th scope="col">Subcategories</th>
                            <th scope="col">
                                <button className="btn btn-outline-success" onClick={onAddCategory}>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         className="bi bi-plus-circle-fill" viewBox="0 0 16 16">
                                        <path
                                            d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
                                    </svg>
                                </button>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        {categories.map( (category, index) => (
                            <tr key={category.id}>
                                <td>{category.categoryName}</td>
                                <td>
                                    {
                                        subCategoriesList(category.subCategories)
                                    }
                                </td>
                                <td>
                                    <button className="btn btn-outline-primary" onClick={ () =>{
                                        onEditCategory(category)
                                    }
                                    }>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" className="bi bi-pencil-fill" viewBox="0 0 16 16">
                                            <path
                                                d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                                        </svg>
                                    </button>
                                    <button className="btn btn-outline-danger ml-1" onClick={() => {
                                        onDelete(category.id, index)
                                    }}>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" className="bi bi-trash-fill" viewBox="0 0 16 16">
                                            <path
                                                d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
                <div className="col-2"/>
            </div>

            <CategoryModal show={showCategoryModal} onCloseCallback={onCloseModal} category={categoryInFocus} onSaveCallback={onSave}/>
        </div>
    )
}

export default Categories