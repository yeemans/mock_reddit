import React from 'react';

class Post extends React.Component {
  render() {
    return (
    <div>
      Hello, I am {this.props.title}!
    </div>
    )
  }
}

export default Post;