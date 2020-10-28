import React from 'react';
import axios from "axios";

// DELETE--ok:
export default class DelDoctor extends React.Component {
  state = {
    id: '',
  }

  handleChange = event => {
    this.setState({ id: event.target.value });
  }

  handleSubmit = event => {
    event.preventDefault();

    // axios.delete(`http://localhost:80/doctor-admin/src/api/api.php?action=delDoctor&doctorid=${this.state.id}`,
    // {
    //   withCredentials:true,
    //   // headers: { 
    //   //     'Content-Type': 'multipart/form-data'
    //   // }
    // })
    //   .then(res => {
    //     console.log(res);
    //     console.log(res.data);
    //   }).catch((error) => {
    //     console.log(error)
    // });
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <label>
            Doctor ID:
            <input type="text" name="id" onChange={this.handleChange} />
          </label>
          <button type="submit">Delete</button>
        </form>
      </div>
    )
  }
}