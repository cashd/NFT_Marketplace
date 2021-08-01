import MenuButton from './Buttons/MenuButton'

const NavBar: React.FC<{}> = ({ children }) => {
  return (
    <div className="h-24  bg-gradient-to-l from-retro-pink via-retro-purple to-retro-blue flex items-center justify-start">
      <div className="ml-10">
        <MenuButton onClick={() => {}} text="Marketplace" />
        <MenuButton onClick={() => {}} text="My Collection" />
      </div>

      <div className="ml-auto">
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
  )
}

export default NavBar
