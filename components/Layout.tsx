import NavBar from './NavBar'

const Layout: React.FC<{}> = ({ children }) => {
  return (
    <div>
      <NavBar />
      <div>{children}</div>
    </div>
  )
}

export default Layout
