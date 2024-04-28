import React from 'react';

function PreviewTextAreaInput({ disabled, label }) {
  return (
    <div>
      <h1 className="mt-5 mb-3">{label}</h1>
      <textarea
        disabled={disabled}
        rows="3"
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight"
      />
    </div>
  );
}

export default PreviewTextAreaInput;
