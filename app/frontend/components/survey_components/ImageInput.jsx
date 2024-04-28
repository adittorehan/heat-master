import React from 'react';

function ImageInput({
  label, disabled, onValueChange,
}) {
  const handleChange = (e) => {
    e.preventDefault();
    onValueChange(e);
  };

  return (
    <div className="flex my-6">
      <div className="w-4/12">
        <label className="text-gray-500" htmlFor={label}>
          {label.charAt(0).toUpperCase() + label.slice(1)}
        </label>
      </div>
      <div className="w-8/12 flex flex-col items-center bg-white text-blue rounded-lg tracking-wide cursor-pointer">
        <input
          id={label}
          className="rounded shadow border w-full px-4 py-2"
          type="file"
          accept="image/*"
          disabled={disabled}
          onChange={handleChange}
        />
      </div>
    </div>
  );
}

export default ImageInput;
