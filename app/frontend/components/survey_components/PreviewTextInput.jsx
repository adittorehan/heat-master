import React from 'react';

function PreviewTextInput({
  label, value, disabled, type,
}) {
  return (
    <div className="my-6">
      <label className="block mb-3" htmlFor={label}>
        {label.charAt(0).toUpperCase() + label.slice(1)}
      </label>
      <input
        id={label}
        className="rounded shadow border border-gray-200 w-full text-gray-700 px-4 py-2"
        type={type}
        value={value}
        disabled={disabled}
      />
    </div>
  );
}

export default PreviewTextInput;
