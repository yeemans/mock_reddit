import Post from 'components/post'
import WebpackerReact from 'webpacker-react'
import Turbolinks from 'turbolinks'

Turbolinks.start()

WebpackerReact.setup({Post})