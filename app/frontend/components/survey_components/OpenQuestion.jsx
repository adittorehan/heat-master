/* eslint-disable jsx-a11y/label-has-associated-control */
import React from 'react';

function OpenQuestion({
  openQuestion, onValueChange, label, id,
}) {
  return (
    <div className="flex mt-6">
      <div className="w-1/3">
        <label className="text-gray-500 text-sm">{label}</label>
      </div>
      <div className="w-2/3">
        <input
          className="ml-2"
          type="radio"
          checked={openQuestion}
          id={`${id}_true`}
          value
          onChange={() => onValueChange(true)}
        />
        <label className="text-gray-500 mr-5 ml-1" htmlFor={`${id}_true`}>
          Yes
        </label>

        <input
          type="radio"
          checked={!openQuestion}
          id={`${id}_false`}
          value={false}
          onChange={() => onValueChange(false)}
        />
        <label className="text-gray-500 ml-1" htmlFor={`${id}_false`}>
          No
        </label>
      </div>
    </div>
  );
}

export default OpenQuestion;
