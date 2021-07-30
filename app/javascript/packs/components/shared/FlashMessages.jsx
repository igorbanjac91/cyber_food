import React, { useEffect, useState } from "react"
import PropTypes from "prop-types"



const FlashMessages = (props) => {

  const [ messages, setMessages ]  = useState(props.messages)

  useEffect(() => {
    setMessages(props.messages)
  })

  function removeMessage() {
    props.removeMessage()
  }

  const flashMessages = messages.map( message => {
    return <Alert key={message.id} message={ message }
            onClose={ () => removeMessage() } />
  })
  
  return (
    <div>
      {flashMessages}
    </div>
  )
};




const Alert = (props) => {

  const message = props.message
  const alertClassname = `alert ${ alertClass(message.type) } fade in`;

  useEffect(() => {
    
    const timer = setTimeout(props.onClose, props.timeout)

    return (
      clearTimeout(timer)
    )
  }, []) 

  function alertClass(type) {
    
    let classes = {
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
      success: 'alert-success'
    }

    return classes[type] || classes.success;
  }


  return (
    <div className={alertClassname}>
      <button className='close'
        onClick={ props.onClose }
        data-dismiss="alert"> &times; </button>
        { message.text }
    </div>
  )
};

Alert.propTypes = {
  onClose: PropTypes.func,
  timeout: PropTypes.number,
  message: PropTypes.object.isRequired
};

Alert.defaultPorps = {
  timeout: 3000
}
export default FlashMessages;