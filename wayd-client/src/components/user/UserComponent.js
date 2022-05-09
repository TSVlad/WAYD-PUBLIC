import UserEditComponent from "./UserEditComponent";
import UserViewComponent from "./UserViewComponent";

const UserComponent = (props) => {
    return (
        <div className={props.className}>
            {props.editMode &&
                <UserEditComponent user={props.user}/>
            }
            {!props.editMode &&
                <UserViewComponent user={props.user}/>
            }
        </div>
    )
}

export default UserComponent