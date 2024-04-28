import React from 'react';

function CheckBoxInput({
  id, disabled, onChange, option,
}) {
  return (
    <div className="flex mb-2">
      <label className="block" htmlFor={`${id}_feedback_checkbox`}>
        <input
          id={`${id}_feedback_checkbox`}
          disabled={disabled}
          onChange={onChange}
          className="mr-2 leading-tight"
          type="checkbox"
        />
        <span className="text-sm">{option}</span>
      </label>
    </div>
  );
}

export default CheckBoxInput;
