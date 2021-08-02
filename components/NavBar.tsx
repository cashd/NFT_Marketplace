import MenuButton from './Buttons/MenuButton'

const NavBar: React.FC<{}> = ({ children }) => {
  return (
    <>
      {/* Full Display Navbar */}
      <div className="h-24  bg-gradient-to-l from-retro-pink via-retro-purple to-retro-blue flex items-center justify-start md:hidden">
        <div className="ml-10 flex">
          <MenuButton
            onClick={() => {}}
            text="Marketplace"
          />
          <MenuButton
            onClick={() => {}}
            text="My Collection"
          />
        </div>

        <div className="ml-auto flex">
          <MenuButton
            onClick={() => {}}
            text="Create"
            borderRadius="rounded-xl"
          />
          <MenuButton
            onClick={() => {}}
            text="Connect Wallet"
            borderRadius="rounded-xl"
          />
        </div>
      </div>

      {/* Mobile Navbar */}
      <div className="h-24  bg-gradient-to-l from-retro-pink via-retro-purple to-retro-blue flex items-center justify-start sm:hidden">
        <MenuButton onClick={() => {}} text="Mobile" />
      </div>
    </>
  )
}

export default NavBar
