interface MenuButtonProps {
  onClick: () => void
  text: string
  borderRadius?: string
}

const MenuButton: React.FC<MenuButtonProps> = ({
  onClick,
  text,
  borderRadius = 'rounded-md',
}) => {
  return (
    <button
      onClick={onClick}
      className={`bg-white  text-gray-700 font-semibold py-2 px-8 bg-opacity-50 mr-5 ${borderRadius}`}
    >
      {text}
    </button>
  )
}

export default MenuButton
