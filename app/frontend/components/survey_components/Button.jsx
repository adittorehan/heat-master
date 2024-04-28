import React from 'react';

function Button({ disabled, link, label }) {
  return (
    <button
      disabled={disabled}
      className="h-10 mr-3 w-24 focus:outline-none bg-gray-300 hover:bg-gray-100 text-gray-800 text-sm font-bold my-3 px-3 border border-gray-400 rounded shadow"
      type="button"
    >
      <a href={link}>{label}</a>
    </button>
  );
}

export default Button;
